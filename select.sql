select * from zavrsni_radovi;

--

select * from prijedlozi_zavrsni;

--

select * from predmeti_zavrsni;

--

select * from studenti_zavrsni;

--

select * from profesori_zavrsni;

--

select * from zavrsni_radovi where idpredmet = 4;

--

select * from prijedlozi_zavrsni where flagCustom = 1;

--

select * from predmeti_zavrsni where id = 4;

--

select * from studenti_zavrsni where ime = 'Franjo';

--

select * from profesori_zavrsni where prezime = 'Zvonic';

--

select
    s.ime,
    s.prezime,
    p.naziv
from
    studenti_zavrsni s,
    prijedlozi_zavrsni p
where
    s.id=p.idstudent;
    
--
    
select
    p.ime,
    p.prezime,
    pr.naziv
from
    profesori_zavrsni p,
    zavrsni_radovi z,
    prijedlozi_zavrsni pr
where
    p.id=z.idprofesor and z.idprijedlog=pr.id;
    
--
    
select
    p.prezime,
    s.ime,
    s.prezime
from
    profesori_zavrsni p,
    zavrsni_radovi z,
    prijedlozi_zavrsni pr,
    studenti_zavrsni s
where
    p.id=z.idprofesor and z.idprijedlog=pr.id and s.id=pr.idstudent
order by p.prezime;
    
--    
    
select
    p.prezime,
    count (s.id)
from
    profesori_zavrsni p,
    zavrsni_radovi z,
    prijedlozi_zavrsni pr,
    studenti_zavrsni s
where
    p.id=z.idprofesor and z.idprijedlog=pr.id and s.id=pr.idstudent
group by p.prezime;

--

select 
    *
from 
    studenti_zavrsni
    inner join prijedlozi_zavrsni on studenti_zavrsni.id=prijedlozi_zavrsni.idstudent;

-- 

select 
    *
from 
    studenti_zavrsni
    left join prijedlozi_zavrsni on studenti_zavrsni.id=prijedlozi_zavrsni.idstudent;
    
--

select 
    studenti_zavrsni.ime,
    studenti_zavrsni.prezime
from 
    studenti_zavrsni
left join prijedlozi_zavrsni on prijedlozi_zavrsni.idstudent=studenti_zavrsni.id
where prijedlozi_zavrsni.idstudent is null;
    
-- 

select
    p.ime,
    p.prezime,
    pr.naziv,
    pd.naziv,
    p.ime,
    p.prezime
from
    studenti_zavrsni s,
    profesori_zavrsni p,
    zavrsni_radovi z,
    prijedlozi_zavrsni pr,
    predmeti_zavrsni pd
where
    p.id=z.idprofesor and z.idprijedlog=pr.id and z.idpredmeti=pd.id and pr.idstudent=s.id;
    
--

select
    p.prezime,
    p.ime,
    pd.naziv
from
    profesori_zavrsni p,
    zavrsni_radovi z,
    predmeti_zavrsni pd
where
    p.id=z.idprofesor and z.idprijedlog=pd.id
order by p.prezime;
    
--

select
    pd.naziv,
    s.ime,
    s.prezime
from
    studenti_zavrsni s,
    prijedlozi_zavrsni p,
    zavrsni_radovi z,
    predmeti_zavrsni pd
where
    p.idstudent=s.id and z.idprijedlog=p.id and z.idpredmeti=pd.id
order by pd.naziv