Exerciţiul 1: Pentru fiecare produs pentru care este cunoscută firma care asigură SERVICE să se
afișeze denumirea, denumirea categoriei și denumirea firmei care asigură SERVICE.

select prod.denumire, c.denumire, p.nume
from produs prod join  producator p
on prod.cod_producator = p.id_producator
join categorie c on (c.id_categorie = prod.cod_categorie)
where p.service is not null;

Exerciţiul 2: Să se afișeze denumirea produselor și numele producatorului produselor cu un preț
cuprins între 2000 si 3000.

select distinct prod.denumire, p.nume
from produs prod join producator p on (prod.cod_producator = p.id_producator)
 join stoc s on (s.cod_produs = prod.id_produs)
where s.pret between 2000 and 3000; 


Exerciţiul 3: Să se afiseze producătorii produselor care conțin în denumire textul 'phone'.
select distinct p.nume
from produs prod join producator p on (prod.cod_producator = p.id_producator)
where prod.denumire like '%phone%';

Exerciţiul 4: Să se afișeze denumirele produselor pentru care s-a făcut ultimul inventar într-o zi din
weekend.
select distinct prod.denumire
from produs prod  join stoc s on (s.cod_produs = prod.id_produs)
where to_char(data_inventar, 'd') in ('7','1')

Exerciţiul 5: Să se afișeze pentru fiecare înregistrare din stoc denumirea produsului, 
a magazinului și numărul de zile care a trecut de 
la ultimul inventar până la data de '01-01-2016'.;
select prod.denumire, m.denumire, 
           case when to_date ('01-01-2016', 'dd-mm-yyyy')  > s.data_inventar 
                    then to_date ('01-01-2016', 'dd-mm-yyyy')  - s.data_inventar 
           else 0 end nr_zile         
from produs prod join stoc s on (prod.id_produs = s.cod_produs)
     join magazin m on (m.id_magazin = s.cod_magazin);


Exerciţiul 6: Să se obțină denumirile categoriile cu cel puțin 10 
produse distincte în stoc.

select prod.cod_categorie, c.denumire , count(distinct prod.id_produs)
from produs prod join categorie c on (c.id_categorie = prod.cod_categorie)
 join stoc s on (s.cod_produs = prod.id_produs)
 group by prod.cod_categorie, c.denumire 
 having count(distinct prod.id_produs) > 5;

Exerciţiul 8: Să se listeze pentru fiecare producător numărul produselor de tip 'tablete', 
numărul produselor de tip 'telefoane' din stoc, 
prețul celei mai scumpe tablete și prețul celui mai scump telefon
precum și numărul total de tipuri de produse.

select p.nume, max(s.pret)
from stoc s join produs prod on (s.cod_produs = prod.id_produs)
                   join categorie c on (prod.cod_categorie = c.id_categorie) 
                   join producator p on (prod.cod_producator = p.id_producator)
group by p.nume ;   

select p.nume, count(distinct  decode(c.denumire, 'telefoane',s.cod_produs, null)  ) nr_tel,
                        count( distinct decode(c.denumire, 'tablete',s.cod_produs, null)  ) nr_tablete,
                        max(  decode(c.denumire, 'telefoane',s.pret, null)  ) max_tel,
                        max(  decode(c.denumire, 'tablete',s.pret, null)  ) max_tablete
from stoc s join produs prod on (s.cod_produs = prod.id_produs)
                   join categorie c on (prod.cod_categorie = c.id_categorie) 
                   join producator p on (prod.cod_producator = p.id_producator)
group by p.nume;   

select p.id_producator, p.nume, m.denumire, 
                        nvl( to_char(sum(s.pret * s.cantitate)), 'fara produse'), 
                        count(distinct id_produs )    
from producator p 
            left  join produs prod on (prod.cod_producator = p.id_producator )
            left join stoc s on (s.cod_produs = prod.id_produs)  
            left join magazin m on (m.id_magazin = s.cod_magazin)
group by p.id_producator, p.nume, m.denumire;             


