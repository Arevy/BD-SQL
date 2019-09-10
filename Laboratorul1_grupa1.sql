select * from employees;

SELECT last_name as nume, 
              salary as "Salariu", 
              job_id "titlu job"
FROM employees;














SELECT rownum nr_crt, 
             first_name "Nume angajat", 
             last_name "Prenume angajat"
FROM employees;
/*  comentariu */
--comment

SELECT sysdate
FROM dual;


select job_id  "cod job",  job_title titlu,
          max_salary - min_salary diferenta
    from jobs;
    
select employee_id cod, last_name nume,
           department_id departament, 
           sysdate- hire_date nr_zile
from employees;           

select employee_id cod, last_name nume,
            commission_pct * salary val_comision
from employees
where commission_pct is not null;

SELECT last_name, first_name, job_id
FROM employees
WHERE manager_id is not NULL;   -- <> NULL;    != NULL

select employee_id cod, last_name nume,
            nvl(commission_pct,0) * salary val_comision
from employees;

SELECT employee_id, last_name, first_name, department_id
FROM employees
WHERE department_id IN (10, 20,80);

SELECT employee_id, last_name,  
            first_name prenume , department_id
FROM employees
WHERE department_id = 10 
     or department_id =  20
     or department_id = 80
order by department_id, 2/*last_name*/, prenume;

Exerciţiul 18: Să se afişeze numele 
şi codul departamentului pentru angajaţii care 
au codul jobului IT_PROG sau HR_REP.
where job_id in ( 'IT_PROG' , 'HR_REP')

select * from employees
where hire_date between  ' 01-JAN-1990 '  and '31-DEC-1990' ;

select * from employees
where hire_date between  
    to_date(' 01-01-1990', 'dd-mm-yyyy')   
    and to_date('31-12-1990','dd-mm-yyyy') ;

select to_char(sysdate , 'dd-mon-yyyy hh:mi:ss AM day')
from dual;
 
1. nr de zile pana la 1.mai
2. cand pica 1 mai in anul curent

select round(to_date('01-05-2017', 'dd-mm-yyyy') - sysdate) 
from dual;

select     
  to_char( 
    to_date(  '01-05-' || to_char(sysdate, 'yyyy') , 'dd-mm-yyyy'),
    'day')
from dual;



















