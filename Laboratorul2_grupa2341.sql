SELECT to_char ( sysdate + INTERVAL '1 1:30:31'  DAY TO SECOND , 'dd hh:mi:ss')
from dual;

select last_name, salary, nvl(commission_pct, 0)
from employees;

select last_name, salary, 
          decode(commission_pct, null, 0 , commission_pct) comision
from employees;

select last_name, salary salariu, 
          decode(department_id, null, 'fara dep' , 10, 'dep 10' , 20, 'dep 20', 'alt dep') dep
from employees
order by 3, salariu desc, last_name;

sa se afiseze numele si prenumele angajatilor. Ordinea va fi data de comision,
primul din lista va fi King indiferent de valaorea comisionului acestuia.

select last_name, first_name, nvl(commission_pct, 0) comision
from employees
order by decode(last_name, 'King', 0, 1 ) , comision;
select last_name, first_name, nvl(commission_pct, 0) comision
from employees
order by decode(manager_id, null, 0, 1 ) , comision;
select last_name, first_name, nvl(commission_pct, 0) comision, 1 ord
from employees
where manager_id is null  /* last_name ==  'King'   <> */
union
select last_name, first_name, nvl(commission_pct, 0) comision, 2 
from employees
where manager_id is not null
order by ord;

select last_name
from employees
--where department_id not in (null, 10, 20, 30); 
where department_id not in (10, 20, 30) and department_id is not null;

select *
from  (SELECT last_name, first_name, salary + nvl(commission_pct,0)* salary venit
           FROM employees 
           ORDER BY venit, last_name, first_name    )
where rownum <=10;


SELECT employee_id, last_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id
and lower(last_name) like '%a%';

SELECT employee_id, last_name, department_name
FROM employees join departments 
    on (employees.department_id = departments.department_id)
WHERE  lower(last_name) like '%a%';

Exerciţiul 8: Să se listeze titlurile job-urilor atribuite angajaţilor
care lucrează în departamentul 30.

select e.last_name, e.job_id , j.job_title
from employees e, jobs j
where e.job_id = j.job_id;

select e.last_name, e.job_id , j.job_title
from employees e join jobs j
on  e.job_id = j.job_id;


select e.last_name, e.job_id , j.job_title, e.department_id, d.department_name
from employees e join jobs j
        on  e.job_id = j.job_id
join departments d
        on (e.department_id = d.department_id );
        
Exerciţiul 9: Să se afişeze numele angajatului, numele departamentului 
şi tara pentru toţi angajaţii care câştigă comision.

select e.last_name, c.country_name, e.commission_pct
from 
employees e join jobs j
on (e.job_id = j.job_id)
  join departments d
  on (e.department_id = d.department_id)
  join locations l
  on (d.location_id = l.location_id)
  join countries c
  on (c.country_id = l.country_id)
 where e.commission_pct is not null; 


*** sa se afiseze pentru fiecare ang numele sau si numele sefului direct        ;
select a.last_name nume, m.last_name nume_manager        
from employees a join employees m        
on (a.manager_id = m.employee_id);

sa se afiseze ang 
care castiga cu cel mult 10000 mai putin decat managerul companiei;

select a.last_name nume, m.last_name nume_manager        
from employees a join employees m        
on (m.manager_id is null and a.salary >= m.salary -10000);

select e.last_name, e.salary,  jg.*
from employees e join job_grades jg
on (e.salary between jg.lowest_sal and jg.highest_sal);

Exerciţiul 11: Să se afişeze numele și denumirea jobului 
actual pentru angajații care au avut funcția
de 'Stock Clerk'.


;
select distinct  e.last_name, e.job_id job_actual, jh.job_id job_anterior,
j.job_title
from job_history jh join employees e
      on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
join jobs j2  on j2.job_id =  jh.job_id
where j2.job_title = 'Stock Clerk';

***Sa sa afiseze angajatii si departamentele
in care lucreaza inclusiv ang pentru care nu e cunoscut dep.
select e.last_name, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

