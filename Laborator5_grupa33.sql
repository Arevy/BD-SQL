select last_name, first_name
from employees
where salary = (select max(salary)
                              from employees
                              );
 
                              
select last_name, first_name
from employees
where salary >=ALL (select salary
                              from employees
                              );
                              
                                 
select last_name, first_name
from employees
where salary <ANY (select salary
                              from employees
                              );                          
                              
=ANY                  <=>  IN      
 <>ALL                <=>  NOT IN          
 
Exerciţiul 7: Să se afle dacă există angajaţi care nu lucrează în departamentul ‘Sales’ 
şi al căror salariu şi comision coincid cu salariul şi comisionul unui angajat din
departamentul ‘Sales’

select last_name, first_name 
from employees
where (salary, commission_pct)  in (
                                select  salary, commission_pct 
                                from employees where 
                                         department_id in 
                                         (select department_id from departments 
                                          where department_name = 'Sales'))
and department_id not in  
                                  (select department_id from departments 
                                          where department_name = 'Sales');         
                                          
Exerciţiul 10: Să se obţină numele salariaţilor
având cea mai mare vechime din departamentul în care lucrează.



select last_name, first_name
from employees
where (department_id, hire_date) in (
                              select department_id, min (hire_date)
                              from employees
                              group by department_id);
                                          
select e.last_name, e.first_name                                          
from employees e, ( select department_id, min (hire_date) minim
                              from employees
                              group by department_id) date_minime       
where    e.department_id = date_minime.department_id 
            and e.hire_date = date_minime.minim;  
            
            

                              
select last_name, first_name
from employees e
where e.hire_date = (    select  min(hire_date) 
                                       from employees
                                       where department_id  = e.department_id);
                              


*** sa se afiseze departamentele in care nu lucreaza niciun angajat

select department_name
from departments
where department_id not in (select department_id from employees 
                                                where department_id is not null);

select department_id from employees order by department_id;
select department_id from departments order by department_id;


select department_name
from departments d
where not exists (select '*' from employees  where department_id = d.department_id);

exe 22.
SELECT employee_id, last_name, department_id id_dep, TO_CHAR(NULL) nume
FROM employees
UNION
SELECT TO_NUMBER(NULL), null, department_id, department_name
FROM departments
ORDER BY 3, nume;





 ***sa se afiseze numele angajatilor care au lucrat cel putin
 in toate departamentele in care a lucrat 206
 
 select e.last_name, e.first_name
 from employees e
 where not exists     (
                  select department_id
                  from job_history
                  where employee_id = 206
                  minus 
                  select department_id
                  from job_history
                  where employee_id = e.employee_id
                  );
 
 
 
 
    select e.last_name, e.first_name
    from employees e
    where  not exists ( select department_id
                                   from job_history
                                   where employee_id = 206
                                    minus                             
                                    select department_id
                                   from job_history
                                   where employee_id = e.employee_id
                                    );

*** sa se afiseze codul departamentelor, codurile joburilor si suma salariilor pentru angajatii care au acelasi job si lucreaza in acelasi dep,
pentru angajatii care lucreaza in acelasi departament pentu toti angajati

 select department_id, job_id job_id, sum(salary) , 1
 from employees group by department_id, job_id
 union 
 select department_id,  null , sum(salary) , 2
 from employees group by department_id
 union 
 select null,  null , sum(salary) , 3
 from employees
 order by department_id, 2; 
 
 select department_id, job_id job_id, sum(salary) , grouping (department_id), 
                          grouping(job_id)
 from employees group by rollup(department_id, job_id)
 order by 1,2;

  group by rollup(A, B, C, D)
 group by A, B, C, D
 union
 group by A, B, C,
 union
 group by A, B
 union
 group by A
 union
 --group by

  select department_id, job_id job_id, sum(salary),
   grouping(department_id),grouping(job_id) 
 from employees group by cube(department_id, job_id)
 order by 1,2;
 
   select department_id, job_id job_id, sum(salary),
   grouping(department_id),grouping(job_id) 
 from employees group by grouping sets(  (department_id, job_id) , ()  )
 order by 1,2;
 
 *** sa se afiseze primii 10 angajati ordinea descrescatoare a salariului
select last_name, first_name, salary
from employees e
where 10 > (select count(*)  from employees where salary > e.salary  )
order by salary desc;

***
sa se afiseze ang care au lucrat la toate proiectele din 98.;
select e.last_name
from employees e join work w on (e.employee_id = w.employee_id) 
join projects p on (w.project_id = p.project_id) 
where to_char(p.start_date,'yyyy') = '1998'
group by e.employee_id, e.last_name
having count(distinct p.project_id) = (select count(*)
                               from projects p 
                               where to_char(p.start_date,'yyyy') = '1998')  ;

 
 
 
 
 
 
 
 
 
 Exerciţiul 15: Să se afiseze codul, numele, prenumele angajatilor care îndeplinesc una dintre
condiţiile următoare
-în departamentul în care lucrează în prezent a ocupat o funcţie diferită de cea actuală
-funcţia pe care o ocupă în prezent a ocupat-o si în alt departament, diferit de cel actual.


select e.employee_id, e.last_name, e.first_name
from employees e join job_history jh
 on ( e.employee_id = jh.employee_id  )
 where e.department_id = jh.department_id and e.job_id <> jh.job_id 
union
 select e.employee_id, e.last_name, e.first_name
from employees e join job_history jh
 on ( e.employee_id = jh.employee_id  )
 where e.department_id <> jh.department_id and e.job_id = jh.job_id; 
 
 select e.employee_id, e.last_name, e.first_name
from employees e join job_history jh
 on ( e.employee_id = jh.employee_id  )
 where (e.department_id = jh.department_id and e.job_id <> jh.job_id )
 or (e.department_id <> jh.department_id and e.job_id = jh.job_id);

 
 
 
 
 
 
                                                 
                                                 
                                                 
                                                 
                                                 
           
                                                 
                                                 