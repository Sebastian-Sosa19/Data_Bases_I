---
---  Create and populates BOYS and GIRLS tables used in Chapter 7.
---

CREATE TABLE GIRLS
 (NAME      VARCHAR(25),
  CITY      VARCHAR(25));

INSERT INTO GIRLS VALUES('Mary','Boston');
INSERT INTO GIRLS VALUES('Nancy',null);
INSERT INTO GIRLS VALUES('Susan','Chicago');
INSERT INTO GIRLS VALUES('Betty','Chicago');
INSERT INTO GIRLS VALUES('Anne','Denver');

CREATE TABLE BOYS
 (NAME      VARCHAR(25),
  CITY      VARCHAR(25));

INSERT INTO BOYS VALUES('John','Boston');
INSERT INTO BOYS VALUES('Henry','Boston');
INSERT INTO BOYS VALUES('George',null);
INSERT INTO BOYS VALUES('Sam','Chicago');
INSERT INTO BOYS VALUES('James','Dallas');

CREATE TABLE PARENTS
 (CHILD      VARCHAR(25),
  TYPE       CHAR(6),
  PNAME      VARCHAR(25));

INSERT INTO PARENTS VALUES('Mary', 'FATHER', 'Francis');
INSERT INTO PARENTS VALUES('Mary','MOTHER', 'Joyce');
INSERT INTO PARENTS VALUES('Nancy', 'FATHER', 'Robert');
INSERT INTO PARENTS VALUES('Nancy','MOTHER', 'Norma');
INSERT INTO PARENTS VALUES('Betty', 'FATHER', 'Cliff');
INSERT INTO PARENTS VALUES('Betty','MOTHER', 'Besita');
INSERT INTO PARENTS VALUES('Anne', 'FATHER', 'Walter');
INSERT INTO PARENTS VALUES('Anne','MOTHER', 'Sophie');
INSERT INTO PARENTS VALUES('John', 'FATHER', 'Carlos');
INSERT INTO PARENTS VALUES('John','MOTHER', 'Marlena');
INSERT INTO PARENTS VALUES('Sam', 'FATHER', 'Joseph');
INSERT INTO PARENTS VALUES('Sam','MOTHER', 'Connie');
INSERT INTO PARENTS VALUES('James', 'FATHER', 'James');
INSERT INTO PARENTS VALUES('James','MOTHER', 'Mary');
commit;


