-- 1
create table EMP_COL as (select * from employees);
create table DEPT_COL as (select * from departments);

-- 2
desc employees;
desc emp_col; 
-- primary key si FK-urile se pierd
desc departments;
desc dept_col;

-- 3
select * from emp_col;
select * from dept_col;

-- 4 (mai lipsesc FK-uri)
ALTER TABLE emp_col
ADD CONSTRAINT pk_emp_col PRIMARY KEY(employee_id);
ALTER TABLE dept_col
ADD CONSTRAINT pk_dept_col PRIMARY KEY(department_id);
ALTER TABLE emp_col
ADD CONSTRAINT fk_emp_dept_col
FOREIGN KEY(department_id) REFERENCES dept_col(department_id);

-- 5
INSERT INTO DEPT_COL(department_id, department_name)
VALUES(300, 'Programare');

-- 6
insert into emp_col
VALUES(208, 'Jessica', 'Doe', 'jessica.doe@gmail.com', null,
      sysdate, 'IT_PROG', 12000, null, null, 300);

-- 7
insert into emp_col(employee_id, first_name, last_name, email,
                    hire_date, job_id, department_id)
VALUES(207, 'John', 'Doe', 'john.doe@gmail.com', 
      to_date('18/05/2016', 'dd/mm/yyyy'), 'IT_PROG', 300);
      
COMMIT;

-- 8
insert into emp_col(employee_id, first_name, last_name, email,
                    hire_date, job_id, department_id)
VALUES(
      (select (max(employee_id) + 1) new_id
      from emp_col),
      'Bob', 'Doe', 'bob.doe@gmail.com', 
      sysdate, 'IT_PROG', 300);

COMMIT;

-- 9
create table EMP1_COL as (select * from employees where 1=0);
insert into emp1_col
select * from employees
where commission_pct > 0.25;

COMMIT;

-- 10
insert into emp_col
values(0, user, user, 'TOTAL', 'TOTAL', sysdate, 'TOTAL',
      (select sum(salary) from emp_col),
      (select avg(commission_pct) from emp_col),
      null, null);

COMMIT;

-- 12
delete from emp1_col;
create table EMP2_COL as (select * from employees where 1=0);
create table EMP3_COL as (select * from employees where 1=0);
insert first 
when salary < 5000 then into emp1_col
when salary >= 5000 and salary < 10000 then into emp2_col
when salary > 10000 then into emp3_col
select *
from employees;

COMMIT;

-- 14
update emp_col
set salary = salary * 1.05;

rollback;

-- 15
update emp_col
set job_id = 'SA_REP'
where department_id = 80 and commission_pct is not null;

rollback;

-- 17
update emp_col e
set (salary, commission_pct) = (select salary, commission_pct
                                from emp_col
                                where employee_id = e.manager_id)
where salary = (select min(salary)
                from emp_col);

-- 19
update emp_col
set salary = (select avg(nvl(salary, 0))
              from emp_col)
where employee_id in (select employee_id
                      from emp_col e
                      where hire_date = (select min(hire_date)
                                        from emp_col
                                        where department_id = e.department_id));
                                    
rollback;

-- 20
update emp_col
set (job_id, department_id) = (select job_id, department_id
                              from emp_col
                              where employee_id = 205)
where employee_id = 114;

rollback;

-- 22
delete from dept_col;

-- 23
delete from emp_col
where commission_pct is null;

rollback;

-- 24
delete from dept_col
where department_id not in (select nvl(department_id, 0)
                            from emp_col);
                            
rollback;


-- 27
savepoint a;

-- 28
delete from emp_col;

select * from emp_col;

-- 29
rollback to a;

select * from emp_col;
