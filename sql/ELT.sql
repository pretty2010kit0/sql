-- INSERT INTO zhou VALUES(null,'guo','1');
-- SELECT * FROM zhou;
SELECT name,gender,ELT(gender+1,'男','女') FROM zhou;
