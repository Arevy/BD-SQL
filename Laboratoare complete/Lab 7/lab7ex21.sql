desc dept_col;

accept p_cod prompt "Introduceti codul departamentului";

select * from dept_col
where department_id = &p_cod;

accept p_nume prompt "Introduceti numele departamentului";
accept p_mgr prompt "Introduceti codul managerului";

update dept_col
set department_name = '&p_nume', manager_id = &p_mgr
where department_id = &p_cod;

rollback;