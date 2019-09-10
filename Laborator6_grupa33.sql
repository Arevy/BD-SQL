create table employees_ibd
as select * from employees;

create table departments_ibd
as select * from departments;

create table jobs_ibd
as select * from jobs where 1 <> 1;

delete from jobs_ibd;
commit;
select * from jobs;

insert into jobs_ibd (job_id, job_title)
values ('SA_MAN', 'Sales Manager');

select * from jobs_ibd;

commit;

insert into jobs_ibd 
values ('AD_PRES', 'President', null, null);

select * from jobs_ibd;

delete from jobs_ibd;

insert into jobs_ibd(job_id, job_title, min_salary, max_salary)
select job_id, job_title, min_salary, max_salary
from jobs;

create table employees_ibd2
as select * from employees where 1 = 2;

create table employees_ibd3
as select * from employees where 1 = 2;

delete from employees_ibd;

rename employees_ibd to employees_ibd1;

insert all
when salary <= 6000 then into employees_ibd1
when salary >= 6000 and salary <=10000 then into employees_ibd2
else into employees_ibd3
select * from employees;

select * from employees_ibd1 where salary = 6000;
select * from employees_ibd2 where salary = 6000;
rollback;

insert first
when salary <= 6000 then into employees_ibd1
when salary >= 6000 and salary <=10000 then into employees_ibd2
else into employees_ibd3
select * from employees;

select * from employees_ibd1 where salary = 6000;
select * from employees_ibd2 where salary = 6000;

***sa se stearga inregistrarile din tabelul copie departments_***
***sa se adauge in tabelul departments_*** departamentul 'sala 223'
cu id-ul 1
***sa se adauge in tabelul departments_*** primele doua departamente
in ordinea desc a nr de ang


delete from departments_ibd;

insert into departments_ibd (department_id, department_name)
values(1, 'sala 223');

insert into departments_ibd
SELECT *  FROM
    (SELECT d.*
    FROM departments d,
      (SELECT department_id, COUNT(department_id) "nr angajati"
      FROM employees WHERE department_id IS NOT NULL
      GROUP BY department_id
      ) nr
    WHERE d.department_id = nr.department_id
    ORDER BY "nr angajati" DESC
    )
WHERE rownum <= 2;
select * from departments_ibd;
rollback;

insert into departments_ibd
SELECT rownum +nvl(id_max, 0) department_id ,
            department_name, location_id, manager_id 
FROM
    (SELECT *
    FROM departments d,
      (SELECT department_id, COUNT(department_id) "nr angajati"
      FROM employees WHERE department_id IS NOT NULL
      GROUP BY department_id
      ) nr, (select max(department_id) id_max from departments_ibd) 
    WHERE d.department_id = nr.department_id
    ORDER BY "nr angajati" DESC
    )
WHERE rownum <= 2;



Eliminaţi departamentele care nu au nici un angajat. Anulaţi modificările.;

delete from departments_ibd d
where not exists (  select '*' 
                                from employees where department_id = d.department_id );
                                
                                
Exercițiul 18: Schimbaţi jobul tuturor salariaţilor din departamentul 80 care au comision în
'SA_REP'. Anulaţi modificările.;

update employees_ibd2
     set job_id = 'SA_REP',
           commission_pct = 0.1
where commission_pct is not null;           
                                                
Exercițiul 22: Să se modifice valoarea emailului pentru angajaţii care câştigă 
cel mai mult în departamentul în care lucrează astfel încât acesta 
să devină iniţiala numelui concatenată cu „_“
concatenat cu prenumele. Anulaţi modificările.;
                                
update employees_ibd2 e
set email = substr(last_name, 1 , 1) || '_' || first_name
where e.salary =  ( select max(salary) from employees where 
                                department_id = e.department_id);
                                
rollback; 

update employees_ibd2 e
set (salary, commission_pct) = 
                             (select salary, commission_pct from employees ee where 
                                ee.department_id = e.department_id
                                and salary = (select max(salary) from employees 
                                                      where ee.department_id =department_id)
                                and rownum = 1)
where e.salary =  ( select min(salary) from employees where 
                                department_id = e.department_id);




                                






delete from departments_ibd;

