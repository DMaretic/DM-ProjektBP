-- brisanje svega iz pojedinih tablica

delete from zavrsni_radovi;
delete from prijedlozi_zavrsni;
delete from predmeti_zavrsni;
delete from studenti_zavrsni;
delete from profesori_zavrsni;

-- uvjetno brisanje iz tablica

delete from zavrsni_radovi where idpredmet = 4;
delete from prijedlozi_zavrsni where flagCustom = 1;
delete from predmeti_zavrsni where id = 4;
delete from studenti_zavrsni where ime = 'Franjo';
delete from profesori_zavrsni where prezime = 'Zvonic';

-- azuriranja za tablicu zavrsni_radovi

update zavrsni_radovi
set idprofesor = 3
where idprofesor = 5;

update zavrsni_radovi
set idprofesor = 8
where idprijedlog = 5;

update zavrsni_radovi
set idpredmeti = 9
where idprijedlog = 3;

update zavrsni_radovi
set idprofesor = 3
where idpredmeti = 4;

-- azuriranja za tablicu prijedlozi_zavrsni

update prijedlozi_zavrsni
set idstudent = null
where id=4;

update prijedlozi_zavrsni
set flagcustom = 1
where id=6;

update prijedlozi_zavrsni
set naziv = 'Statisticka analiza'
where idstudent=4;

update prijedlozi_zavrsni
set idstudent = null
where flagcustom = 1;

-- azuriranja za tablicu profesori_zavrsni

update profesori_zavrsni
set ime = 'Andrija'
where ime = 'Andrej';

update profesori_zavrsni
set prezime = 'Zvonar'
where prezime = 'Zvonic';

update profesori_zavrsni
set ime = 'Stevo'
where id=8;

update profesori_zavrsni
set prezime = 'Mihailovic'
where id=3;

-- azuriranja za tablicu predmeti_zavrsni

update predmeti_zavrsni
set naziv = 'Internet i drustvo'
where id=1;

update predmeti_zavrsni
set naziv = 'Algoritmi i strukture podataka'
where id=6;

update predmeti_zavrsni
set naziv = 'Primjene mikroracunala'
where naziv = 'Mikroracunala';

update predmeti_zavrsni
set naziv = 'Matematicki alati'
where naziv = 'Matematika';

-- azuriranja za tablicu studenti_zavrsni

update studenti_zavrsni
set ime = 'Jure'
where ime = 'Juraj';

update studenti_zavrsni
set prezime = 'Franjevac'
where prezime = 'Franjic';

update studenti_zavrsni
set ime = 'Sestar'
where id=9;

update studenti_zavrsni
set prezime = 'Matkovic'
where id=6;

-- naredbe za popunjavanje tablica

INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Internet');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Programiranje');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Baze podataka');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Matematika');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Digitalna tehnika');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Algoritmi');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Elektrotehnika');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Mikroracunala');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('IT i primjene');
INSERT INTO PREDMETI_ZAVRSNI (NAZIV) VALUES ('Racunalne mreze');

INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Juraj','Juric','123','jjuric@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Ivan','Ivanovic','123','iivanovic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Josip','Josipovic','123','jjosipovic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Jovan','Jovanovic','123','jjovanovic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Luka','Lukic','123','llukic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Matija','Matic','123','mmatic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Katarina','Katic','123','kkatic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Franjo','Franjic','123','ffranjic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Petar','Petrovic','123','ppetrovic@vub.hr');
INSERT INTO STUDENTI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Dominik','Domic','123','ddomic@vub.hr');

INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Grga','Grgic','123','ggrgic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Jan','Janic','123','jjanic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Mihael','Mihaelovic','123','mmihaelovic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Duro','Duric','123','dduric@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Ilija','Ilicic','123','iilicic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Andrej','Andric','123','aandric@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Ante','Antic','123','aantic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Stjepan','Stjepic','123','sstjepic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Nikola','Nikolajevic','123','nnikolajevic@vub.hr');
INSERT INTO PROFESORI_ZAVRSNI (IME, PREZIME,ZAPORKA,EMAIL) VALUES ('Zvonimir','Zvonic','123','zzvonic@vub.hr');

INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Web pretrazivac',1,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Kalkulator za poslovanje',2,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Odabir zavrsnog rada',3,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Analiza statistike',4,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Komercijalna upotreba registra',5,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Proces razvijanja algoritama',6,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Razvoj elektricnih vodova',7,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Primjene Arduino-a',8,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Internet of Things - primjena',9,0);
INSERT INTO PRIJEDLOZI_ZAVRSNI (NAZIV, IDSTUDENT, FLAGCUSTOM) VALUES ('Poslovne mreze racunala',10,0);

INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (1,1,10);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (2,2,9);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (3,3,8);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (4,4,7);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (5,5,6);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (6,6,5);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (7,7,4);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (8,8,3);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (9,9,2);
INSERT INTO ZAVRSNI_RADOVI (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) VALUES (10,10,1);

commit
