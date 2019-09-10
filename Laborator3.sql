select e.last_name, e.job_id job_actual, 
     j.min_salary - nvl(j2.min_salary, 0) dif
from job_history jh right join employees e
      on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
left join jobs j2  on j2.job_id =  jh.job_id
order by e.last_name;

select  jh.*, e.*, j.*
from job_history jh right join employees e
      on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
order by jh.employee_id, e.employee_id;


SELECT department_id, AVG(salary) medie_sal
FROM employees
GROUP BY department_id;
SELECT e.department_id, e.salary, e.last_name,d.department_name
FROM employees e join departments d on (e.department_id = d.department_id)
where e.salary > 3000
order BY e.department_id;

SELECT e.department_id, d.department_name, avg(e.salary) medie
FROM employees e join departments d on (e.department_id = d.department_id)
where e.salary > 3000
group BY e.department_id, d.department_name
order by e.department_id, d.department_name; --avg(salary)
--sum, min, max, count, avg
***pentru fiecare dep si pentru fiecare job_title  sa se afiseze numele dep, titlul jobului si cel mai mic salariu al angajatilor 
care lucreaza in acel dep cu acel job_title.

select d.department_name, j.job_title, min(salary)
from employees e join departments d on (e.department_id = d.department_id)
                              join jobs j on (e.job_id = j.job_id)
group by d.department_name, j.job_title;                              

Exerciţiul 6: Pentru fiecare şef, să se afişeze codul si numele său şi salariul celui mai prost platit subordonat.
Se vor exclude cei pentru care codul managerului nu este cunoscut. De asemenea, se vor exclude
grupurile în care salariul minim este mai mic de 8000$. Sortaţi rezultatul în ordine descrescătoare a
salariilor.

select e.manager_id, m.last_name, min(e.salary)
from employees e join employees m on (e.manager_id = m.employee_id)
group by e.manager_id, m.last_name
having min(e.salary) > 8000;


select count(commission_pct) ang_cu_comision,
           count(department_id) ang_cu_dep,
           count(*) nr_total_de_ang,
           count(distinct department_id) nr_total_departamente
from  employees;

*** sa se afiseze numele angajatilor si cate joburi au avut anterior acestia.

select e.last_name, count(jh.employee_id)
from employees e left join job_history jh on (e.employee_id = jh.employee_id)
group by e.employee_id, e.last_name

Exerciţiul 10: Să se obţină numele angajaților care lucreaza în departamentul
cu cea mai mare medie a salariilor.;
select * from employees
where department_id in (
    select department_id
    from employees 
    group by department_id
    having avg(salary) = (          
              select max(medie) medie_max
              from 
                        (
                        select avg(salary) medie
                        from employees 
                        group by department_id
                        )
              )
    );
*** sa se afise pentru ficare an in care s-au facut angajari (yyyy din hire_date) sa
se afiseze cati s-au angajat in dep 50, cati s-au ang in dep 60, cati s-au ang in dep 80,
cati s-au ang in total in acel an.

select to_char(hire_date, 'yyyy'), decode(department_id, 50, 50, null ) d50,
                                                    decode(department_id, 60, 60, null ) d60, 
                                                    decode(department_id, 80, 80, null ) d80,
           department_id
from employees
order by to_char(hire_date, 'yyyy'), department_id;

select to_char(hire_date, 'yyyy'), count( decode(department_id, 50, 50, null )) d50,
                                                    count(decode(department_id, 60, 60, null )) d60, 
                                                    count(decode(department_id, 80, 80, null )) d80,
                                                    count(*) toate_dep
from employees
group by to_char(hire_date, 'yyyy');

***sa se afiseze pentru fiecare ang numele si diferenta dintre salariul sau si media 
in departamentul in care lucreaza

select e.last_name, e.salary - medii.medie
            from employees e join 
                      (
                      select department_id, avg(salary) medie
                      from employees
                      group by department_id
                      )  medii
              on (e.department_id = medii.department_id);







