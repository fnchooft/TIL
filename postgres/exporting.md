Exporting data in xml-format
============================

It took me a while to get to this, you get close to the wanted result, but the docs are funky:

```
echo "select table_to_xml('table_name',true, false, '')" | PGPASSWORD=yourpassword psql -U postgres -h 127.0.0.1 testdb_dev -qAt -o /tmp/table.xml
```


