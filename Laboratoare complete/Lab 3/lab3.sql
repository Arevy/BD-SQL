-- 1
select a.last_name, replace(to_char(a.hire_date, 'month-yyyy'), ' ', '')
from employees a
join employees b using (department_id)
where lower(b.last_name) = 'gates'
and lower(a.last_name) like '%a%';

-- 2
select distinct a.employee_id, a.last_name, department_id, d.department_name
from employees a
join employees b using (department_id)
join departments d using (department_id)
where lower(b.last_name) like '%t%'
order by a.last_name;

-- 3
select e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees e
join jobs j using (job_id)
join departments d using(department_id)
join locations l using(location_id)
join countries c using(country_id)
join employees m on e.manager_id = m.employee_id
where lower(m.last_name) = 'king';

-- 4
select department_id, d.department_name, e.last_name, e.job_id, to_char(e.salary, '$999,999.99') "Salariu"
from employees e
join departments d using(department_id)
where lower(d.department_name) like '%ti%'
order by d.department_name, e.last_name;

-- 5
select e.last_name, department_id, d.department_name, l.city, e.job_id
from employees e
join departments d using(department_id)
join locations l using(location_id)
where lower(l.city) = 'oxford';

-- 6
select distinct a.employee_id, a.last_name, a.salary
from employees a
join jobs j using (job_id)
join employees b using (department_id)
join departments d using (department_id)
where lower(b.last_name) like '%t%'
and a.salary >= ((j.min_salary + j.max_salary) / 2)
order by a.last_name;

-- 7
select e.last_name, d.department_name
from employees e
left outer join departments d using(department_id);

-- 9
select d.department_name, e.last_name
from departments d
left outer join employees e using(department_id);

-- 10
select e.last_name, d.department_name
from employees e
full outer join departments d using(department_id);

-- 11
select d.department_id "Departament"
from departments d
where lower(d.department_name) like '%re%'
union
select e.department_id
from employees e
where lower(e.job_id) = 'sa_rep';

-- 12
select d.department_id "Departament"
from departments d
where lower(d.department_name) like '%re%'
union all
select e.department_id
from employees e
where lower(e.job_id) = 'sa_rep';

-- 13
SELECT d.department_id "Cod departament"
FROM departments d
MINUS
SELECT e.department_id
FROM employees e;

-- 13 alta varianta (important sa nu am null in subcerere)
SELECT d.department_id
FROM departments d
WHERE d.department_id NOT IN 
(SELECT DISTINCT e.department_id
FROM employees e
WHERE e.department_id IS NOT NULL);

-- 14
select e.department_id
from employees e
where lower(e.job_id) = 'hr_rep'
intersect
select d.department_id
from departments d
where lower(d.department_name) like '%re%';

-- 15
select e.employee_id, e.job_id, e.last_name
from employees e
where e.salary >= 3000
union
select e.employee_id, job_id, e.last_name
from employees e
join jobs j using(job_id)
where e.salary = ((j.min_salary + j.max_salary) / 2);

-- 16 (folosim > any, in loc de >, fiindca putem avea mai multi gates)
select last_name, hire_Date
from employees
where hire_date > any (select hire_date
from employees
where lower(last_name) = 'gates');

-- 17
select last_name, salary
from employees
where department_id in (select department_id
from employees
where lower(last_name) = 'gates') 
and lower(last_name) <> 'gates';

-- 18
select last_name, salary
from employees
where manager_id in (select employee_id
from employees
where manager_id is null);

-- 19
select last_name, department_id, salary
from employees
where (department_id, salary) in (select department_id, salary
from employees
where commission_pct is not null);

-- 20
select e.employee_id, e.last_name, e.salary
from employees e
where e.department_id in (select e2.department_id
from employees e2
where lower(e2.last_name) like '%t%')
and e.salary >= (select (j.max_salary + j.min_salary) / 2
from jobs j
where j.job_id = e.job_id)
order by e.last_name;

-- 21
select last_name
from employees
where salary > all (select salary
from employees
where upper(job_id) like '%CLERK%')
order by salary desc;

-- 22
select e.last_name, d.department_name, e.salary
from employees e
left outer join departments d using (department_id)
where e.commission_pct is null
and e.manager_id in (select employee_id
from employees
where commission_pct is not null);

-- 23
select e.last_name, d.department_name, e.salary, j.job_title
from employees e
left outer join departments d using (department_id)
join jobs j using (job_id)
where (e.salary, nvl(e.commission_pct, 0)) in (select salary, nvl(commission_pct, 0)
from employees
where department_id in (select department_id
from departments
where location_id in (select location_id
from locations
where lower(city) = 'oxford')));

-- 24
select last_name, department_id, job_id
from employees
where department_id in (select department_id
from departments
where location_id in (select location_id
from locations
where lower(city) = 'toronto'));