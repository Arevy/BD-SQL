-- 1 (varianta 1)
select distinct e.employee_id, e.first_name, e.last_name
from works_on w
join employees e on(w.employee_id = e.employee_id)
where not exists (select 'a'
                  from project p
                  where to_char(p.start_date, 'mm') <= 6
                  and to_char(p.start_date, 'yyyy') = '2006'
                  and not exists (select 'b'
                                from works_on ww
                                where ww.project_id = p.project_id
                                and ww.employee_id = w.employee_id));

-- 1 (varianta 2)
select employee_id, first_name, last_name
from works_on join employees using(employee_id)
where project_id in (select project_id
                    from project p
                    where to_char(p.start_date, 'mm') <= 6
                    and to_char(p.start_date, 'yyyy') = '2006')
group by employee_id, first_name, last_name
having count(project_id) = (select count(project_id)
                            from project p
                            where to_char(p.start_date, 'mm') <= 6
                            and to_char(p.start_date, 'yyyy') = '2006');
                            
-- 1 (varianta 4)
select distinct e.employee_id, e.first_name, e.last_name
from works_on w
join employees e on(w.employee_id = e.employee_id)
where not exists (select project_id
                  from project p
                  where to_char(p.start_date, 'mm') <= 6
                  and to_char(p.start_date, 'yyyy') = '2006'
                  minus
                  (select project_id
                  from works_on ww
                  where w.employee_id = ww.employee_id));
                  
-- 2 (varianta 1)
select distinct p.project_id, p.project_name
from works_on w
join project p on(w.project_id = p.project_id)
where not exists (select 'a'
                  from employees e
                  where employee_id in (select employee_id
                                        from job_history
                                        group by employee_id
                                        having count(*) >= 2)
                  and not exists (select 'b'
                                from works_on ww
                                where ww.employee_id = e.employee_id
                                and ww.project_id = w.project_id));
                                
-- 2 (varianta 2)
select project_id, project_name
from works_on join project using(project_id)
where employee_id in (select employee_id
                      from job_history
                      group by employee_id
                      having count(*) >= 2)
group by project_id, project_name
having count(employee_id) = (select count(count(employee_id))
                            from job_history
                            group by employee_id
                            having count(*) >= 2);
                            
-- 2 (varianta 3)
select distinct w.project_id, p.project_name
from works_on w join project p on (p.project_id = w.project_id)
where not exists
  (select employee_id
  from job_history
  group by employee_id
  having count(*) >= 2
  minus
  (select employee_id
  from works_on
  where project_id = w.project_id));
  
-- 3
select count(e.employee_id) 
from employees e
where (select count(job_id)
      from job_history
      where employee_id = e.employee_id) + nvl2(job_id, 1, 0) >= 3;
      
-- 4
select country_name, count(employee_id)
from countries
left join locations using(country_id)
left join departments using(location_id)
left join employees using(department_id)
group by country_id, country_name
order by 2 desc;

-- 5
select employee_id, last_name
from employees e
where (select count(project_id)
        from works_on
        join project using(project_id)
        where employee_id = e.employee_id
        and deadline < delivery_date) >= 2;

-- 15 I
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;

-- 15 II
DEFINE p_cod;
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;
UNDEFINE p_cod;

-- 15 III
DEFINE p_cod=100;
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &&p_cod;
UNDEFINE p_cod;

-- 15 IV
ACCEPT p_cod PROMPT "cod= ";
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;

-- 16
select last_name, department_id, (salary * (1 + nvl(commission_pct, 0)) * 12) "Salariu anual"
from employees
where lower(job_id) = lower('&job_code');