accept p_last_name prompt "Introduceti numele angajatului:";
accept p_first_name prompt "Introduceti prenumele angajatului:";
accept p_salary prompt "Introduceti salariul angajatului:";

insert into emp_col(employee_id, first_name, last_name, email,
                    hire_date, job_id, salary, department_id)
VALUES((select (max(employee_id) + 1) from emp_col),
      '&p_first_name', '&p_last_name', 
      substr(lower('&p_first_name'), 1, 1) || substr(lower('&p_last_name'), 1, 7) || '@gmail.com', 
      sysdate, 'IT_PROG', &p_salary, 300);
      
COMMIT;