*** sa se afiseze pentru fiecarea ngajat numele sau si orasul in care lucreaza

*** sa se afiseze pentru ficare ang numele si denumirea dep in care lucreaza

select e.last_name, d.department_name
from employees e join departments d
on (e.department_id = d.department_id);

select e.last_name, d.department_name, l.city
 from employees e join departments d
  on (e.department_id = d.department_id)
 join locations l
  on (d.location_id = l.location_id);

select e.last_name, d.department_name, d.*
from employees e left join departments d
on (e.department_id = d.department_id);

select e.last_name, d.department_name, d.*
from employees e right join departments d on (e.department_id = d.department_id);

select e.last_name, d.department_name, d.*
from employees e full  join departments d on (e.department_id = d.department_id);

select e.last_name, d.department_name, l.city
 from employees e left join departments d on (e.department_id = d.department_id)
 left join locations l on (d.location_id = l.location_id);
 
  ***sa se afiseze toti ang, pentru cei fara istoric se va afisa sal min al job actual 
select distinct  e.last_name, e.job_id job_actual, 
     j.min_salary - nvl(j2.min_salary, 0) dif
from job_history jh right join employees e
      on jh.employee_id = e.employee_id
join jobs j on  e.job_id = j.job_id
left join jobs j2  on j2.job_id =  jh.job_id
order by e.last_name;

SELECT department_id, salary sal
FROM employees
order  BY department_id;

SELECT department_id
FROM employees
group BY department_id;

SELECT d.department_id, d.department_name, AVG(salary) medie_sal
FROM employees e join departments d on (e.department_id = d.department_id )
GROUP BY d.department_id, d.department_name
order by AVG(salary) desc;


Exerciţiul 5: Scrieţi o cerere pentru a se afişa numele departamentului,
numărul de angajaţi
şi salariul mediu pentru angajaţii din acel departament care nu castiga comision. 
Coloanele vor fi etichetate corespunzător.

SELECT d.department_name, count(*) nr_ang, AVG(salary) medie_sal
FROM employees e join departments d on (e.department_id = d.department_id )
where commission_pct is null
GROUP BY d.department_id, d.department_name
order by AVG(salary) desc;
  
  
Exerciţiul 6: Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost
platit subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut.
De asemenea, se vor exclude
grupurile în care salariul minim este mai mic de 4000$. 
Sortaţi rezultatul în ordine descrescătoare a salariilor.
  
select e.employee_id, e.last_name, e.manager_id, m.last_name, e.salary
from employees e join employees m on (e.manager_id = m.employee_id)
where e.manager_id is not null
order by e.manager_id;

select e.manager_id, m.last_name, min (e.salary) sal_min_subordonat, count(*) nr_sub
from employees e join employees m on (e.manager_id = m.employee_id)
where e.manager_id is not null
group by e.manager_id, m.last_name
having min (e.salary) > 4000;

select last_name, manager_id, salary from employees
where
(manager_id, salary)  in (
        select e.manager_id, min (e.salary) sal_min_subordonat
        from employees e join employees m on (e.manager_id = m.employee_id)
        where e.manager_id is not null
        group by e.manager_id, m.last_name
        having min (e.salary) > 4000 )    
order by manager_id;

Exerciţiul 10: Să se obţină numele angajaților care lucreaza în departamentul 
cu cea mai mare  medie a salariilor si numele dep in care lucreaza.

  select e.last_name, dep_max.department_name
  from employees e join
    (select d.department_id, department_name, avg(salary) from employees e join departments d on (e.department_id = d.department_id)
    group by d.department_id, d.department_name
    having avg(salary) = (
                                      select max(medie_dep)  
                                            from (
                                          select department_id, avg(salary) medie_dep
                                          from employees group by department_id
                                            ) 
                                      )   
    ) dep_max
  on e.department_id = dep_max.department_id;
  



*****sa se afise pe cate o linie un an in care s-au facut angajari
coloanele afisate vor fi anul, numarul de angajari in dep 80, 
                                               numarul de angajari in dep 100,
                                               numarul de angajari in dep 90
                                               numarul total de angajati.
                                               
select to_char( hire_date, 'yyyy') an, department_id
from employees
order by to_char( hire_date, 'yyyy'), department_id;


select count( commission_pct  )
from employees;

select last_name, salary salariu, 
          decode(department_id, null, 'fara dep' , 10, 'dep 10' , 20, 'dep 20', 'alt dep') dep
from employees
order by 3, salariu desc, last_name;

select to_char( hire_date, 'yyyy') an, department_id, 
           decode( department_id , 80, 80 ,  null    )  dep80,
             decode( department_id , 50, 50 ,  null    )  dep50,
              decode( department_id , 60, 60 ,  null    )  dep60
from employees
order by to_char( hire_date, 'yyyy'), department_id;
 
select to_char( hire_date, 'yyyy') an, department_id
from employees
order by to_char( hire_date, 'yyyy');


--rez final ***: 
select to_char( hire_date, 'yyyy') an, 
           count( decode( department_id , 80, 80 ,  null    ) )  dep80,
           count(  decode( department_id , 50, 50 ,  null    ))  dep50,
           count(   decode( department_id , 60, 60 ,  null    ))  dep60, count(*)
from employees
group by to_char( hire_date, 'yyyy');
 
  

                                               


  

