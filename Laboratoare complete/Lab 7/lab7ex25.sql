accept p_cod prompt "Introduceti codul angajatului";

select * from emp_col
where employee_id = &p_cod;

delete from emp_col
where employee_id = &p_cod;

rollback;