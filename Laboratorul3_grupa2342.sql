*** sa se afiseze numele ang si denumirea dep in care lucreaza fiecare ang, 
se vor afisa si angajatii pentru care nu este cunoscut dep;


select e.last_name, 
     decode ( d.department_name, null , 'dep necunoscut', department_name) dep,
     decode(d.location_id ,  1500, 'l 1500', 2500, 'l 2500', 'alta locatie' ) locatie
from employees e left join departments d
 on (e.department_id = d.department_id );
 
 select e.*, d.*
from employees e left join departments d
 on (e.department_id = d.department_id );

 sa se afiseze pentru fiecare ang, orasul in care lucreaza
 se vor afisa si angajatii pentru care nu este cunoscut dep; 
 
 select e.last_name, l.city
 from employees e left join departments d
  on (e.department_id = d.department_id )
 left  join locations l
   on (l.location_id = d.location_id);
   
*** sa se afiseze pentru ficare ang numele si diferenta dintre min_salary al jobului actual
si min_sal al joburilor anterioare.
pentru ang care nu au avut joburi anterioare se va afisa 0
ordonati dupa numele ang;

select e.last_name, nvl( joba.min_salary - jobh.min_salary ,0)
from job_history jh right join employees e
on (jh.employee_id = e.employee_id)
 left   join jobs jobh
 on (jobh.job_id = jh.job_id)
    join jobs joba
 on (joba.job_id = e.job_id)   
 order by e.last_name;
   
SELECT d.department_id, d.department_name, AVG(salary) medie_sal
FROM employees e join departments d
 on e.department_id = d.department_id
GROUP BY d.department_id , d.department_name;

SELECT d.department_id, d.department_name, salary sal
FROM employees e join departments d
 on e.department_id = d.department_id
order BY d.department_id , d.department_name;

SELECT d.department_id, d.department_name, AVG(salary) medie_sal
FROM employees e join departments d
 on e.department_id = d.department_id
 where e.commission_pct is  null
GROUP BY d.department_id , d.department_name
having avg(salary) > 8000 and d.department_id in (70, 100, 20, 110);



SELECT MAX(salary) “Maxim”, MIN(salary) “Minim”, SUM(salary) “Suma”,
AVG(salary) “Media”
FROM employees;

SELECT e.job_id, j.job_title, MAX(salary) "Maxim", 
              MIN(salary) "Minim", SUM(salary) "Suma",
AVG(salary) "Media"
FROM employees e join jobs j
on e.job_id = j.job_id
group by e.job_id, j.job_title;


select a.manager_id, m.last_name, count(*) nr_subordonati, 
     min (a.salary) sal_minim
from employees a join employees m
on a.manager_id = m.employee_id
group by a.manager_id, m.last_name;

Exerciţiul 8:
select a.manager_id, m.last_name, count(*) nr_subordonati, 
     min (a.salary) sal_minim
from employees a join employees m
on a.manager_id = m.employee_id
group by a.manager_id, m.last_name, m.department_id, m.manager_id
having count(*) >= 5
and m.manager_id is not null and  m.department_id  in (    --dep din orasul sefului  
                        select department_id from departments d1 join locations l1
                        on (l1.location_id = d1.location_id)
                        where city
                       in (select l.city
                            from locations l join departments d
                            on (l.location_id = d.location_id
                            ) join  employees e
                            on (d.department_id = e.department_id)
                              and e.manager_id is null)
)  ;

Exerciţiul 14:
Să se determine numărul angajaţilor care câştigă comision.
select count(commission_pct)
from employees;
   --care nu castiga
select count(*) - count(commission_pct)
from employees;   
   -- cate sunt dep in care lucreaza ang
select count(distinct department_id)
from employees;



Exerciţiul 9: Să se obţina codul, titlul şi salariul mediu al job-ului 
pentru care salariul mediu este minim.
select *
from      (SELECT e.job_id, j.job_title, avg(salary) medie
              FROM employees e join jobs j
              on e.job_id = j.job_id
              group by e.job_id, j.job_title
             order by avg(salary) 
             )
where rownum <2;

select min(medie)
from      (SELECT e.job_id, j.job_title, avg(salary) medie
              FROM employees e join jobs j
              on e.job_id = j.job_id
              group by e.job_id, j.job_title
             );

SELECT e.job_id, j.job_title, avg(salary) medie
              FROM employees e join jobs j
              on e.job_id = j.job_id
              group by e.job_id, j.job_title
              having avg(salary ) =  (select min(medie)
                                                   from   
                                                      (SELECT e.job_id, j.job_title, avg(salary) medie
                                                       FROM employees e join jobs j
                                                      on e.job_id = j.job_id
                                                        group by e.job_id, j.job_title
                                                       )
                                                  );
                                                  
                                                  
--exe 16

select job_id, sum(decode(department_id, 10, salary, 0)) sdep10, 
           sum(decode(department_id, 20, salary, 0)) sdep20, 
          sum(decode(department_id, 30, salary, 0)) sdep30, sum(salary) sal
from employees 
group by job_id;
              
              
              
              
              )


   
   