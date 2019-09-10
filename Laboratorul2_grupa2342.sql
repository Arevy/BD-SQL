6.51SELECT last_name, first_name, department_id
FROM employees
WHERE department_id = 30
ORDER BY last_name, first_name;

SELECT last_name, first_name, department_id
FROM employees
ORDER BY 3, 1, 2;

SELECT rownum, last_name, first_name, salary + nvl(commission_pct,0)* salary venit
FROM employees
ORDER BY venit, last_name, first_name;

SELECT rownum, last_name, first_name, salary + nvl(commission_pct,0)* salary venit
FROM employees where rownum <=10
ORDER BY venit, last_name, first_name;

select *
from  (SELECT last_name, first_name, salary + nvl(commission_pct,0)* salary venit
           FROM employees 
           ORDER BY venit, last_name, first_name    )
where rownum <=10;

Exerciţiul 2: Să se afişeze angajaţii în ordinea descrescătoare a salariului. Angajaţii care au acelaşi
salariu vor fi afişaţi în ordinea descrescătoare a comisionului.;

select employee_id, last_name, salary, commission_pct 
from employees
order by salary desc , commission_pct desc nulls first ; 


SELECT to_char ( sysdate + INTERVAL '1 1:30:31'  DAY TO SECOND , 'dd hh:mi:ss')
from dual;

SELECT employee_id, last_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employee_id, last_name, department_name, e.department_id,
              e.manager_id manager_ang, d.manager_id manager_dep
FROM employees e, departments d
WHERE e.department_id = d.department_id
and lower(last_name) like '%a%';

SELECT employee_id, last_name, department_name
FROM employees join departments 
    on (employees.department_id = departments.department_id);

SELECT employee_id, last_name, department_name, e.manager_id manager_ang, 
    d.manager_id manager_dep
FROM employees e join departments d
    on (e.department_id = d.department_id);
    
    
    
SELECT e.employee_id, e.last_name, d.department_name, j.job_title
FROM employees e join departments d
    on (e.department_id = d.department_id)
  join jobs j on (e.job_id = j.job_id);    
    
*** nume ang, nume dep, tara    
    
SELECT e.employee_id, e.last_name, d.department_name, c.country_name
FROM employees e join departments d
    on (e.department_id = d.department_id)    
 join locations l on (l.location_id = d.location_id)
 join countries c on (c.country_id = l.country_id)
 where lower(last_name) like '%a%';

*** nume angajat, nume sef
select e.last_name "nume ang", m.last_name "nume sef"
from employees e, employees m
where e.manager_id = m.employee_id;

select e.last_name "nume ang", m.last_name "nume sef"
from employees e join employees m
on e.manager_id = m.employee_id;

select  e.last_name, e.job_id, jh.job_id, j.job_title, j2.job_title
from job_history jh join employees e
on jh.employee_id = e.employee_id
join jobs j on (e.job_id = j.job_id)
join jobs j2 on (jh.job_id = j2.job_id);




select distinct  e.last_name, e.job_id job_actual, jh.job_id job_anterior,
j.job_title
from job_history jh join employees e
on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
join jobs j2  on j2.job_id =  jh.job_id
where j2.job_title = 'Stock Clerk';

jh.job_id = 'ST_CLERK'; --- job_title = 'Stock Clerk'

*** se se afiseze angajatii care au lucrat pe cel putin un post mai "prost platit"
max_salary al jobului actual > cel putin un max_salary din istoric.

select distinct  e.last_name, e.job_id job_actual, j.job_title
from job_history jh join employees e
on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
join jobs j2  on j2.job_id =  jh.job_id
where j.max_salary > j2.max_salary;


select e.last_name, e.salary,  jg.*
from employees e join job_grades jg
on (e.salary between jg.lowest_sal and jg.highest_sal);












