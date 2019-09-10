-- 1
select department_name, job_title, round(avg(salary), 2) "Salariu mediu",
      1 - grouping(department_name) "Dep used", 1 - grouping(job_title) "Job used"
from employees
join departments using(department_id)
join jobs using(job_id)
group by rollup(department_name, job_title);

-- 2
select department_name, job_title, round(avg(salary), 2) "Salariu mediu",
      decode(grouping(department_name), 0, 'Dep', '') "Dep used",
      decode(grouping(job_title), 0, 'Job', '') "Job used"
from employees
join departments using(department_id)
join jobs using(job_id)
group by cube(department_name, job_title);

-- 3
select department_name, job_title, e.manager_id, max(salary) "Salariu maxim", sum(salary) "Suma salarii"
from jobs
left outer join employees e using(job_id)
right outer join departments using(department_id)
group by grouping sets((department_name, job_title),
                      (job_title, e.manager_id),
                      ()
                      );
                
-- 4
select max(salary)
from employees
having max(salary) > 15000;

-- 5
select last_name, first_name, department_name, job_id, salary,
        (select round(avg(salary), 2)
          from employees
          where department_id = e.department_id) "Medie salarii colegi",
        (select count(*)
          from employees
          where department_id = e.department_id) "Nr. colegi"  
from employees e
left join departments d on(e.department_id = d.department_id)
where salary > (select nvl(avg(salary), 0)
                from employees
                where department_id = e.department_id)
order by department_name;

-- 6
select first_name, last_name, department_id, salary
from employees
where salary > (select max(avg(salary))
                from employees
                group by department_id);
                
-- 6 bis
select first_name, last_name, department_id, salary
from employees
where salary > ALL(select avg(salary)
                from employees
                group by department_id);
                
-- 7
select first_name, last_name, department_id, salary
from employees e
where salary = (select nvl(min(salary), e.salary)
                from employees
                where department_id = e.department_id)
order by department_id;

-- 8
select department_name, first_name, last_name, hire_date
from employees e
left join departments d on(e.department_id = d.department_id)
where hire_date = (select nvl(min(hire_date), e.hire_date)
                  from employees
                  where department_id = e.department_id)
order by department_name;

-- 9
select first_name, last_name, department_id, salary
from employees e
where exists (select *
              from employees
              where department_id = e.department_id
              and salary = (select max(salary)
                            from employees
                            where department_id = 30));
                            
-- 10
select first_name, last_name, salary
from (select first_name, last_name, salary
      from employees
      order by salary desc)
where rownum <= 3
order by salary;

-- 11
select e.employee_id, e.last_name, e.first_name
from employees e
where (select count(employee_id)
      from employees
      where manager_id = e.employee_id
      group by manager_id) >= 2;
      
-- 12
select city
from locations
where location_id in (select location_id
                      from departments);
                      
-- 12 cu cerere sincronizata
select l.city
from locations l
where exists (select 'Orice'
              from departments
              where location_id = l.location_id);
              
-- 13
select department_id, department_name
from departments
where department_id not in (select department_id
                            from employees
                            where department_id is not null);
                        
-- 13 cu cerere sincronizata
select d.department_id, d.department_name
from departments d
where not exists (select 'Orice'
                  from employees
                  where department_id = d.department_id);

-- 14 a)
select employee_id, last_name, hire_date, manager_id
from employees
where manager_id in (select employee_id
                    from employees
                    where lower(last_name) like 'de haan');
                    
-- 14 b)
select employee_id, lpad(last_name, length(last_name) + 2 * (level - 1), '_') "Nume",
        hire_date, manager_id
from employees
start with lower(last_name) like 'de haan'
connect by prior employee_id = manager_id
order by level;

-- 15
select employee_id, lpad(last_name, length(last_name) + 2 * (level - 1), '_') "Nume",
        hire_date, manager_id
from employees
start with employee_id = 114
connect by prior employee_id = manager_id
order by level;

-- 16 
select employee_id, manager_id, last_name, level
from employees
where level = 3
start with lower(last_name) like 'de haan'
connect by prior employee_id = manager_id
order by level;

-- 17
select employee_id, manager_id, level,
        lpad(last_name, length(last_name) + 2 * (level - 1), '_') "Nume"
from employees
connect by prior manager_id = employee_id;

-- 18
select employee_id, lpad(last_name, length(last_name) + 2 * (level - 1), '_') "Nume",
        salary, level, manager_id
from employees
where salary >= 5000
start with salary = (select max(salary)
                      from employees)
connect by prior employee_id = manager_id
order by level;

-- 19
with A as (select department_id, department_name, sum(salary) suma
                  from employees
                  join departments using(department_id)
                  group by department_name, department_id),
      B as (select avg(sum(salary)) medie
            from employees
            group by department_id)
select department_id, department_name, suma
from A, B
where suma > (select medie from B);

-- 20
with A as (select employee_id, job_id, first_name || ' ' || last_name Angajat,
                  hire_date, manager_id
          from employees),
      C as (select employee_id King
            from employees
            where lower(last_name) = 'king' and lower(first_name) = 'steven'),
      D as (select min(hire_date) Vechime
            from employees, C
            where manager_id = King),
      E as (select employee_id
            from employees, C, D
            where manager_id = King and hire_date = Vechime)
select employee_id, lpad(Angajat, length(Angajat) + 2 * (level - 1), '_'),
        job_id, hire_date, manager_id
from A
where to_char(hire_date, 'yyyy') <> '1970'
start with employee_id in (select employee_id from E)
connect by prior employee_id = manager_id
order by level;

-- 21
select employee_id, last_name, salary
from (select *
      from employees
      order by salary desc)
where rownum <= 10;

-- 22
select job_id, medie
from (select job_id, avg(salary) medie
      from employees
      group by job_id
      order by 2)
where rownum <= 3;

-- 23
select 'Departamentul ' || department_name || ' este condus de ' ||
        nvl(to_char(manager_id), 'nimeni') || ' si ' ||
        nvl2(nullif(nr_ang, 0), 'are numarul de salariati ' || nr_ang, 'nu are salariati') "Info departament"
from departments
left outer join (select department_id, count(employee_id) nr_ang
      from employees
      group by department_id) using(department_id);

-- 24
select last_name, first_name, length(last_name) "Lg. nume", length(first_name) "Lg. prenume"
from employees
where nullif(length(last_name), length(first_name)) is not null;

-- 25
select last_name, hire_date, salary,
    decode(to_char(hire_date, 'yyyy'), '1989', salary * 1.2,
                                        '1990', salary * 1.15,
                                        '1991', salary * 1.10,
                                        salary) "Salariu marit"
from employees;

-- 26
select j.job_id, j.job_title, 
      (case
          when lower(j.job_title) like 's%' then salarySum
          when j.job_id in (select job_id
                          from employees
                          where salary in (select max(salary)
                                          from employees)) then salaryAvg
          else (select min(salary)
                from employees
                group by job_id
                having job_id = j.job_id)
      end) "Info"
from jobs j
join (select job_id, sum(salary) salarySum, avg(salary) salaryAvg
      from employees
      group by job_id) t on(t.job_id = j.job_id);