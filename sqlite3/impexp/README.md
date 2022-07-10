SQLite3 - is the bomb

install extension:

sudo apt install libsqlite3-mod-impexp

Test:

```
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
sqlite> .load libsqlite3_mod_impexp
sqlite> SELECT export_xml('out.xml', 0, 2, 'TBL_A', 'ROW', 'A','sqlite_master');
4
```

Output:
```
$ cat out.xml 
  <TBL_A>
   <ROW>
    <a TYPE="INTEGER">1</a>
    <b TYPE="REAL">2.1</b>
   </ROW>
   <ROW>
    <a TYPE="INTEGER">3</a>
    <b TYPE="TEXT">foo</b>
   </ROW>
   <ROW>
    <a TYPE="TEXT"></a>
    <b TYPE="NULL"></b>
   </ROW>
   <ROW>
    <a TYPE="BLOB">&#x01;&#x02;&#x03;</a>
    <b TYPE="TEXT">&lt;blob&gt;</b>
   </ROW>
  </TBL_A>
```

Links:
 - http://www.ch-werner.de/sqliteodbc/html/impexp_8c.html
 - https://stackoverflow.com/questions/11643611/execute-sqlite-script
