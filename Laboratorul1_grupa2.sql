select * from employees;

SELECT last_name as nume, salary as "Salariu", job_id "titlu job"
FROM employees;


SELECT rownum "Nr. crt", 
    first_name "Numele angajatului", 
    last_name "Prenumele angajatului"
FROM employees;

SELECT sysdate
FROM dual;

select job_id id_job,
        job_title titlu_job, 
        max_salary- min_salary diferenta
from jobs;

select employee_id cod_ang,
    last_name nume_ang,
    department_id cod_dep,
    round(sysdate-hire_date, 2) nr_zile
from employees;    

Să se afişeze numele angajaţilor și valoarea comisionului raportată la salariu.
select employee_id cod_ang,
    last_name nume_ang,
    salary * nvl(commission_pct, 0) 
from employees;

SELECT last_name, first_name, job_id
FROM employees
WHERE manager_id is NULL;   --where manager_id is not null

SELECT DISTINCT job_id
FROM employees;

SELECT DISTINCT job_id, department_id
FROM employees;

SELECT last_name || ' ' || first_name || ' ' || job_id || ' ' || salary 
                                        "nume functie si salariu"
FROM employees;



SELECT employee_id, last_name, first_name, department_id
FROM employees
WHERE department_id IN (10, 20, 80);

SELECT employee_id, last_name, first_name, department_id
FROM employees
WHERE department_id = 10 or department_id = 20
or department_id = 80;

select last_name, department_id 
from employees 
where job_id in ( 'IT_PROG','HR_REP' ); 


SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 6000 AND 17000;

select last_name, hire_date
from employees;

alter session set nls_date_format = 'yyyy dd mm';
-- to_date(sdata, format)     to_char(data, format)   

select last_name, to_char(hire_date, 'yy dd mon hh:mi AM')
from employees;

select to_char(sysdate, 'yy dd mon hh:mi AM')
from dual;

select to_date('31-12-2017','dd-mm-yyyy' ) - sysdate
from dual;

select last_name, first_name
from employees
where lower(first_name) like '%l%l%';




