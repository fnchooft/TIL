.load libsqlite3_mod_impexp
SELECT export_xml('out.xml', 0, 2, 'TBL_A', 'ROW', 'A','sqlite_master');
SELECT export_csv('out.csv', 1, 'aa', 'A', NULL);
SELECT export_sql('out.sql',0,'A');
SELECT export_json('out.json','select a,b from A');