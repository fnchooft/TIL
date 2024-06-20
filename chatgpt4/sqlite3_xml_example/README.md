Export data from SQLite3
========================

With the new ChatGPT4 version becoming available for free, lets play a bit.

ChatGPT4-Question
-----------------

```
As an expert developer, show a valid example of loading data into SQLite3 from the linux-command line. Show how to use an export plugin to generate an XML-file. Make sure that the export xml functionality is generic and can export any table by giving it the tablename as parameter.
```

See the *.md files for the responses from ChatGPT4.

 - First iteration was quite successfull - using awk to export the data.
 - Second iteration was less sound since the answer was a dream ( -xml ).
 - Third iteration the request was made to add schema-data to the exported xml-file.

Here we go down a rabbit-hole.

Eventhough the generated results give the general idea, there are too many tiny
exceptions which need to be taken into account.

Example PRAGMA foreign_key_list(TABLE_NAME)
--------------------------------------------

The general idea is not bad - use the schema-tables from SQLite to generate the
requested information.

Example output:
```
-- sqlite> PRAGMA foreign_key_list(nodes);
-- id          seq         table       from        to          on_update   on_delete   match
-- ----------  ----------  ----------  ----------  ----------  ----------  --------    ------------
-- 0           0           types       typeid      id          NO ACTION   NO ACTION   NONE
```

But now comes the tricky part, **table**, **from** are reserved words in SQL.
Thus if you want to use them to need to "escape" them.

Thus the first draft by ChatGPT4 misses this fact, and eventhought the very
handy cat << 'EOF' > $OUTPUT_FILENAME .... EOF construct is used to generate
the script-files the many different escapings are not handled correctly.

Some iterations were needed to fix this.

Observations
------------

### Devide and Conquer

In order to understand the problem at hand, you need to break the script apart.
This was done by making sure that we first can test the select-statements which
are quite complex with case-statements in order to generate the requested data.

See the [get_schema-template](get_schema.tmpl) and the [get_schema-constraints-template](get_schema_constraints.tmpl).


- Here we first get the select-statements working
- We need to take reserved-words __(from,table,select)__ into account
- We use 'sed' to inject the table-name
- We use backticks and cat to read the schema back

See the [ChatGPT-Iteration2-version](ChatGPT-Iteration2.md#L90) at line 90.

### Caveats

 - The schema-files is used as temporary file - no its not nice
   - But is simplifies the construction

SQLite3 - other TIL
-------------------

Use the built-in commands:

 - **.dump** : Look at the result, later use **grep 'INSERT INTO'** and **grep -v**

Links
-----
 - https://stackoverflow.com/questions/55224392/column-names-of-pragma-foreign-key-list


Notes
-----

-- sqlite> PRAGMA foreign_key_list(nodes);
-- id          seq         table       from        to          on_update   on_delete   match
-- ----------  ----------  ----------  ----------  ----------  ----------  --------    ------------
-- 0           0           types       typeid      id          NO ACTION   NO ACTION   NONE


Why not use pragma table_xinfo('pragma_table_info') to find out what the columns of the pragma_table_info virtual table are? I get the following output (yours will be different):

```
sqlite> pragma table_xinfo('pragma_table_info');
┌─────┬──────────────┬──────┬───────────┬──────┬─────────┬────────────┬────┬───────┬─────────┬────────┐
│ cid │     name     │ type │    aff    │ coll │ notnull │ dflt_value │ pk │ rowid │ autoinc │ hidden │
├─────┼──────────────┼──────┼───────────┼──────┼─────────┼────────────┼────┼───────┼─────────┼────────┤
│ -1  │ NULL         │ NULL │ 'INTEGER' │ NULL │ 0       │ NULL       │ 1  │ 1     │ 0       │ 1      │
│ 0   │ 'cid'        │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 1   │ 'name'       │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 2   │ 'type'       │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 3   │ 'aff'        │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 4   │ 'coll'       │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 5   │ 'notnull'    │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 6   │ 'dflt_value' │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 7   │ 'pk'         │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 8   │ 'rowid'      │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 9   │ 'autoinc'    │ NULL │ 'BLOB'    │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 0      │
│ 10  │ 'arg'        │ ''   │ 'NUMERIC' │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 1      │
│ 11  │ 'schema'     │ ''   │ 'NUMERIC' │ NULL │ 0       │ NULL       │ 0  │ 0     │ 0       │ 1      │
└─────┴──────────────┴──────┴───────────┴──────┴─────────┴────────────┴────┴───────┴─────────┴────────┘
```

You will note that:
- the output columns are described together with
- two HIDDEN columns called arg and schema.
  - These are the input parameters to the virtual table.

**arg** is the argument of the pragma function, in this case the **table** name.
**schema** is the schema in which to look for the **table** name.

Example:

```
select * from pragma_table_info where arg='table' and schema='schema';
```