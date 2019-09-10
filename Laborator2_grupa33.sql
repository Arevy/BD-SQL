select last_name, nvl(commission_pct , 0) comision, department_id
from employees
where nvl(commission_pct , 0) > 0
order by department_id, last_name;

select last_name, nvl(commission_pct , 0) comision
from employees
order by comision desc, last_name;  --order by 2   sau order by nvl(commission_pct , 0) 


select last_name, nvl(commission_pct , 0) comision, department_id
from employees
order by department_id, last_name;


select last_name, decode(commission_pct, null, 0 , commission_pct)
from employees;

select last_name,
           decode(department_id , 10, 'dep 10', 20, 'dep 20', 30, 'dep 30', 'alt dep') dep
from employees;           

sa se ordoneze angajatii dupa valoarea comisionului (descrescator).
primul afisat va fi managerul companiei, indifirent de comisionul acestuia.

select last_name, nvl(commission_pct , 0) comision
from employees
order by decode(manager_id, null, 2,  
                    decode(commission_pct, null, 0 , commission_pct) ) desc, last_name; 
                    
select last_name, nvl(commission_pct , 0) comision
from employees
order by decode(manager_id, null, 0, 1),   
                    decode(commission_pct, null, 0 , commission_pct)  desc, last_name; 




SELECT employee_id, last_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT e.employee_id, e.last_name, d.department_name, e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, d.department_name, e.department_id
FROM employees e join departments d
              on ( e.department_id = d.department_id);
              
              
Exerciţiul 8: Să se listeze titlurile job-urilor atribuite angajaţilor 
care lucrează în departamentul 30.


SELECT e.employee_id, e.last_name, j.job_title, e.department_id
FROM employees e join jobs j
              on ( e.job_id = j.job_id)   -- on (e.job_id = j.job_id and e.department_id = 30)
where e.department_id = 30;


Exerciţiul 9: Să se afişeze numele angajatului, numele departamentului, titlu job
şi tara pentru toţi
angajaţii care câştigă comision.

SELECT e.employee_id, e.last_name, j.job_title, e.department_id
FROM employees e join jobs j
              on ( e.job_id = j.job_id)
   join departments  d
    on  (e.department_id = d.department_id)
   join locations l
    on (l.location_id = d.location_id)
   join countries c
    on (c.country_id = l.country_id)
where commission_pct is not null   ;

***sa se afiseze pentru ficare angajat numele si numele sefului direct.


select  a.last_name "nume angajat", m.last_name "nume sef"
from employees a  join employees m
on a.manager_id = m.employee_id;


Exerciţiul 11: Să se afişeze numele și denumirea jobului actual 
pentru angajații care au avut funcția de 'Stock Clerk'.

select distinct e.last_name, joba.job_title
from job_history jh join employees e
on (jh.employee_id = e.employee_id)
    join jobs jobh
 on (jobh.job_id = jh.job_id)
    join jobs joba
 on (joba.job_id = e.job_id)   
where jobh.job_title = 'Stock Clerk';  

*** sa se afiseze angajatii si numele de departament. Pentru angajatii
pentru care nu este cunoscut departamentul se va afisa 'departament necunoscut'.

select e.last_name, nvl(d.department_name, 'departament necunoscut')
from employees e left outer join departments d
  on (e.department_id = d.department_id);


SELECT e.employee_id, e.last_name,  e.department_id
FROM employees e 
  left  join departments  d
    on  (e.department_id = d.department_id)
 left  join locations l
    on (l.location_id = d.location_id)
 left   join countries c
    on (c.country_id = l.country_id);


SELECT e.employee_id, e.last_name, e.department_id, c.country_name
FROM employees e
   left  join departments  d
    on  (e.department_id = d.department_id)
   left join locations l
    on (l.location_id = d.location_id)
   left join countries c
    on (c.country_id = l.country_id);


** * sa se afiseze pentru fiecare angajat salariul minim inregistrat pentru jobul sau
si salariul minim inregistrat pentru jobul mangarului sau direct.
Va aparea in rezultata si angajatul care nu are manager direct.


*** sa se afiseze numele angajatilor si numele mangerilor acestora rezultatul va 
contine coloanele nume manager, nume angajat. liniile vor fi ordonate dupa 
mangeri. Vor aparea in rezultat 
(pe prima coloana) si angajatii care nu au subordonati

select a.last_name, jm.min_salary sal_min_manager, ja.min_salary sal_min_angajat
from employees a  left join employees m
 on (a.manager_id = m.employee_id)
 left join jobs jm 
 on (m.job_id = jm.job_id)
join jobs ja
 on (a.job_id = ja.job_id);

select  m.last_name, e.last_name subordonat
from employees e   right join    employees m 
on (e.manager_id = m.employee_id)
order by m.last_name;

              
              
select last_name, grade_level
from employees e join job_grades j
on ( e.salary between j.lowest_sal and j.highest_sal );






                    



