-- 1 a)
create table ANGAJATI_COL (
  cod_ang number(4),
  nume varchar2(20),
  prenume varchar2(20),
  email char(15),
  data_ang date DEFAULT sysdate,
  job varchar2(10),
  cod_sef number(4),
  salariu number(8, 2),
  cod_dep number(2)
);

desc angajati_col;
drop table angajati_col;

-- 1 b)
create table ANGAJATI_COL (
  cod_ang number(4) PRIMARY KEY,
  nume varchar2(20) NOT NULL,
  prenume varchar2(20),
  email char(15),
  data_ang date DEFAULT sysdate,
  job varchar2(10),
  cod_sef number(4),
  salariu number(8, 2) NOT NULL,
  cod_dep number(2)
);

desc angajati_col;
drop table angajati_col;

-- 1 c)
create table ANGAJATI_COL (
  cod_ang number(4),
  nume varchar2(20) NOT NULL,
  prenume varchar2(20),
  email char(15),
  data_ang date DEFAULT sysdate,
  job varchar2(10),
  cod_sef number(4),
  salariu number(8, 2) NOT NULL,
  cod_dep number(2),
  PRIMARY KEY(cod_ang)
);

desc angajati_col;

select table_name, constraint_name, constraint_type
from user_constraints
where lower(table_name) = 'angajati_col';

drop table angajati_col;

-- 1 (constrangeri cu nume)
create table ANGAJATI_COL (
  cod_ang number(4),
  nume varchar2(20) constraint nn_ang_col_nume NOT NULL,
  prenume varchar2(20),
  email char(15),
  data_ang date DEFAULT sysdate,
  job varchar2(10),
  cod_sef number(4),
  salariu number(8, 2) constraint nn_ang_col_salariu NOT NULL,
  cod_dep number(2),
  constraint pk_ang_col PRIMARY KEY(cod_ang)
);

desc angajati_col;

select table_name, constraint_name, constraint_type
from user_constraints
where lower(table_name) = 'angajati_col';

-- 3
create table ANGAJATI10_COL as
select * from angajati_col
where cod_dep = 10;

select * from angajati10_col;
desc angajati10_col;

-- 4
alter table angajati_col
add (comision number(4, 2));

desc angajati_col;

-- 5
alter table angajati_col
modify (salariu number(6, 2));

-- 6
alter table angajati_col
modify (salariu default 1000);

-- 7
alter table angajati_col
modify (comision number(2, 2), salariu number(10, 2));

-- 8
update angajati_col
set comision = 0.1
where lower(job) like 'a%';

commit;

select * from angajati_col;

-- 9
alter table angajati_col
modify (email varchar2(15));

-- 10
alter table angajati_col
add (nr_telefon varchar2(10) default '0744123456');

-- 11
select * from angajati_col;

alter table angajati_col
drop column nr_telefon;

-- 12
rename angajati_col to angajati3_col;

-- 13
select * from tab;

rename angajati3_col to angajati_col;

-- 14
truncate table angajati10_col;

-- 15
create table DEPARTAMENTE_COL (
  cod_dep number(2),
  nume varchar2(15) constraint nn_dep_col_nume NOT NULL,
  cod_director number(4)
);

-- 16
insert into departamente_col
values(10, 'Administrativ', 100);

insert into departamente_col
values(20, 'Proiectare', 101);

insert into departamente_col
values(30, 'Programare', null);

-- 17
alter table departamente_col
add constraint pk_dep_col PRIMARY KEY(cod_dep);

desc departamente_col;