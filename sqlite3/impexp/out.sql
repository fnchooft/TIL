BEGIN TRANSACTION;
CREATE TABLE A(a,b);
INSERT INTO "A" VALUES(1,2.1);
INSERT INTO "A" VALUES(3,'foo');
INSERT INTO "A" VALUES('',NULL);
INSERT INTO "A" VALUES(X'010203','<blob>');
COMMIT;
