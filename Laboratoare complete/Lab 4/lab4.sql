-- 2
select max(salary) "Maxim", min(salary) "Minim", sum(salary) "Suma", round(avg(salary), 2) "Medie"
from employees;

-- 3
select job_id, max(salary) "Maxim", min(salary) "Minim", sum(salary) "Suma", round(avg(salary), 2) "Medie"
from employees
group by job_id;

-- 4
select job_id, count(employee_id)
from employees
group by job_id;

-- 5
select count(distinct manager_id) "Nr. manageri"
from employees;

-- 6
select max(salary) - min(salary) "Diferenta salariu maxim-minim"
from employees;

-- 7
select department_name "Departament", city "Oras", count(employee_id) "Nr. angajati", round(avg(salary), 2) "Salariu mediu"
from employees
right outer join departments using (department_id)
join locations using (location_id)
group by department_id, department_name, city
order by count(employee_id) desc;

-- 8
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
from employees)
order by salary desc;

-- 9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 1000
order by min(salary) desc;

-- 10
select department_id, department_name, max(salary)
from employees
join departments using(department_id)
group by department_id, department_name
having max(salary) >= 3000;

-- 11
select min(avg(salary))
from employees
group by job_id;

-- 12
select department_id, department_name, nvl(sum(salary), 0)
from employees
right outer join departments using (department_id)
group by department_id, department_name
order by 3 desc;

-- 13
select max(avg(salary))
from employees
join departments using (department_id)
group by department_id;

-- 14
select job_id, job_title, avg(salary)
from employees
join jobs using (job_id)
group by job_id, job_title
having avg(salary) in
(select min(avg(salary))
from employees
join jobs using (job_id)
group by job_id);

-- 15
select avg(salary)
from employees
having avg(salary) > 2500;

-- 16
select department_id, job_id, sum(salary)
from employees
group by department_id, job_id
order by department_id, job_id;

-- 16 2.0
select department_name, job_title, sum(salary)
from employees
left outer join departments using(department_id)
join jobs using (job_id)
group by department_id, job_id, department_name, job_title
order by department_id, job_id;

-- 17
select department_name, min(salary)
from employees
join departments using(department_id)
group by department_id, department_name
having avg(salary) in
(select max(avg(salary))
from employees
group by department_id);

-- 18 a
select department_id, department_name, count(*) "Nr. angajati"
from employees
join departments using (department_id)
group by department_id, department_name
having count(*) <= 4
order by 3 desc;

-- 18 b
select department_id, department_name, count(*) "Nr. angajati"
from employees
join departments using (department_id)
group by department_id, department_name
having count(*) in
(select max(count(*))
from employees
join departments using (department_id)
group by department_id);

-- 19
select last_name, hire_date
from employees
where to_char(hire_date, 'dd') in
(select to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd')
having count(*) in
(select max(count(*))
from employees
group by to_char(hire_date, 'dd')))
order by hire_date;

-- 20
select count(count(*)) "Nr.departamente"
from employees
group by department_id
having count(*) >= 15;

-- 21
select department_id, sum(salary)
from employees
where department_id != 30
group by department_id
having department_id in
(select department_id
from employees
group by department_id
having count(*) > 10)
order by sum(salary);

-- 22
select *
from
  (select last_name, department_id, job_id, salary
  from employees)
full outer join
  (select department_id, department_name, count(*) "Nr.colegi",
          round(avg(salary)) "Salariu mediu colegi"
  from employees
  right outer join departments using (department_id)
  group by department_id, department_name)
using (department_id)
order by department_id;

-- 23
select department_name, job_title, city, sum(salary)
from employees
join departments using (department_id)
join jobs using (job_id)
join locations using (location_id)
where department_id > 80
group by department_id, department_name, job_id, job_title, location_id, city;

-- 24
select last_name, count(*) "Nr.joburi"
from employees
join job_history using (employee_id)
group by employee_id, last_name
having count(*) >= 2;

-- 25
select round(avg(nvl(commission_pct, 0)), 4) "Comision mediu"
from employees;

-- 26 rollup
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(department_id, TO_CHAR(hire_date, 'yyyy'));

-- 26 cube
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE(department_id, TO_CHAR(hire_date, 'yyyy'));

-- 27
select job_id,
  sum(decode(department_id, 30, salary, 0)) "Dep30",
  sum(decode(department_id, 50, salary, 0)) "Dep50",
  sum(decode(department_id, 80, salary, 0)) "Dep80",
  sum(salary)
from employees
group by job_id
order by 2 desc, 3 desc, 4 desc;

-- 27 cu subcereri in select
select E.job_id,
  (select nvl(sum(salary), 0)
  from employees
  where E.job_id = job_id and department_id = 30) "Dep30",
  (select nvl(sum(salary), 0)
  from employees
  where E.job_id = job_id and department_id = 50) "Dep50",
  (select nvl(sum(salary), 0)
  from employees
  where E.job_id = job_id and department_id = 80) "Dep80",
  sum(salary)
from employees E
group by E.job_id
order by 2 desc, 3 desc, 4 desc;

-- 28
select count(decode(TO_CHAR(hire_date, 'yyyy'), '1997', employee_id)) "1997",
      count(decode(TO_CHAR(hire_date, 'yyyy'), '1998', employee_id)) "1998",
      count(decode(TO_CHAR(hire_date, 'yyyy'), '1999', employee_id)) "1999",
      count(decode(TO_CHAR(hire_date, 'yyyy'), '2000', employee_id)) "2000",
      count(employee_id) "Total angajati"
from employees;

-- 28 cu subcereri in select
select 
  (select count(*)
  from employees
  where TO_CHAR(hire_date, 'yyyy') = '1997') "1997",
  (select count(*)
  from employees
  where TO_CHAR(hire_date, 'yyyy') = '1998') "1998",
  (select count(*)
  from employees
  where TO_CHAR(hire_date, 'yyyy') = '1999') "1999",
  (select count(*)
  from employees
  where TO_CHAR(hire_date, 'yyyy') = '2000') "2000",
  (select count(*)
  from employees) "Total angajati"
from dual;

-- 29
select E.last_name, E.job_id, E.salary, D.department_id, D.department_name,
  (select count(employee_id) 
    from employees
    where department_id = E.department_id) "Nr.colegi",
  (select round(avg(salary))
    from employees
    where department_id = E.department_id) "Salariu mediu departament"
from employees E
full outer join departments D on (E.department_id = d.department_id)
order by department_id;

-- 30
select department_id, department_name, nvl(suma, 0)
from departments D
left outer join (select department_id, sum(salary) suma
      from employees
      group by department_id) t using(department_id)
order by 3 desc;

-- 31
select last_name, salary, department_id, round(salariuMediu, 2)
from employees E
left outer join (select department_id, avg(salary) salariuMediu
      from employees
      group by department_id) t using(department_id);
      
-- 32
select last_name, salary, department_id, round(salariuMediu, 2), nvl(nrColegi, 0)
from employees E
left outer join (select department_id, avg(salary) salariuMediu, count(employee_id) nrColegi
      from employees
      group by department_id) t using(department_id);
      
-- 33
select department_name, last_name, minsal
from departments d
left outer join (select department_id, min(salary) minsal
      from employees
      group by department_id) using(department_id)
left outer join employees using(department_id)
where salary = minsal or minsal is null
order by department_id;
