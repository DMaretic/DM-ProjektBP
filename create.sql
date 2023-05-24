-- brisanje tablica i sekvenca

drop table zavrsni_radovi; 
drop table prijedlozi_zavrsni;
drop table studenti_zavrsni;
drop table predmeti_zavrsni;
drop table profesori_zavrsni;

drop sequence ZAVRSNI_RADOVI_ID_SEQ;
drop sequence PRIJEDLOZI_ZAVRSNI_ID_SEQ;
drop sequence STUDENTI_ZAVRSNI_ID_SEQ;
drop sequence PREDMETI_ZAVRSNI_ID_SEQ;
drop sequence PROFESORI_ZAVRSNI_ID_SEQ;

-- stvaranje tablica

CREATE TABLE studenti_zavrsni (
	ID NUMBER(9, 0) NOT NULL, -- unikatan identifikator stavke unutar tablice
	ime VARCHAR2(40) NOT NULL, -- ime studenta
	prezime VARCHAR2(40) NOT NULL, -- prezime studenta
    zaporka VARCHAR2(20) NOT NULL, -- zaporka
    email VARCHAR2(80) UNIQUE NOT NULL, -- email
	constraint STUDENTI_ZAVRSNI_PK PRIMARY KEY (ID)); -- postavljanje identifikatora kao primarni klju? tablice

CREATE sequence STUDENTI_ZAVRSNI_ID_SEQ; -- broja? identifikatora

CREATE trigger BI_STUDENTI_ZAVRSNI_ID -- inkrementator identifikatora
  before insert on studenti_zavrsni
  for each row
begin
  select STUDENTI_ZAVRSNI_ID_SEQ.nextval into :NEW.ID from dual;
end;

/
CREATE TABLE predmeti_zavrsni (
	ID NUMBER(9, 0) NOT NULL, -- unikatan identifikator stavke unutar tablice
	naziv VARCHAR2(80) NOT NULL, -- naziv predmeta
	constraint PREDMETI_ZAVRSNI_PK PRIMARY KEY (ID)); -- postavljanje identifikatora kao primarni klju? tablice

CREATE sequence PREDMETI_ZAVRSNI_ID_SEQ; -- broja? identifikatora

CREATE trigger BI_PREDMETI_ZAVRSNI_ID -- inkrementator identifikatora
  before insert on predmeti_zavrsni
  for each row
begin
  select PREDMETI_ZAVRSNI_ID_SEQ.nextval into :NEW.ID from dual;
end;

/
CREATE TABLE profesori_zavrsni (
	ID NUMBER(9, 0) NOT NULL, -- unikatan identifikator stavke unutar tablice
	ime VARCHAR2(40) NOT NULL, -- ime profesora
	prezime VARCHAR2(40) NOT NULL, -- prezime profesora
    zaporka VARCHAR2(20) NOT NULL, -- zaporka
    email VARCHAR2(80) UNIQUE NOT NULL, -- email
	constraint PROFESORI_ZAVRSNI_PK PRIMARY KEY (ID)); -- postavljanje identifikatora kao primarni klju? tablice

CREATE sequence PROFESORI_ZAVRSNI_ID_SEQ; -- broja? identifikatora

CREATE trigger BI_PROFESORI_ZAVRSNI_ID -- inkrementator identifikatora
  before insert on profesori_zavrsni
  for each row
begin
  select PROFESORI_ZAVRSNI_ID_SEQ.nextval into :NEW.ID from dual;
end;

/
CREATE TABLE zavrsni_radovi (
	ID NUMBER(9, 0) NOT NULL, -- unikatan identifikator stavke unutar tablice
	IDprijedlog NUMBER(9, 0) UNIQUE NOT NULL, -- identifikator prijedloga
	IDpredmeti NUMBER(9, 0) NOT NULL, -- identifikator predmeta pod kojim rad pripada
	IDprofesor NUMBER(9, 0) NOT NULL, -- identifikator mentora zavr?nog rada
	constraint ZAVRSNI_RADOVI_PK PRIMARY KEY (ID)); -- postavljanje identifikatora kao primarni klju? tablice

CREATE sequence ZAVRSNI_RADOVI_ID_SEQ; -- broja? identifikatora

CREATE trigger BI_ZAVRSNI_RADOVI_ID -- inkrementator identifikatora
  before insert on zavrsni_radovi
  for each row
begin
  select ZAVRSNI_RADOVI_ID_SEQ.nextval into :NEW.ID from dual;
end;

/
CREATE TABLE prijedlozi_zavrsni (
	ID NUMBER(9, 0) NOT NULL, -- unikatan identifikator stavke unutar tablice
	naziv VARCHAR2(160) NOT NULL, -- naziv prijedloga zavr?nog rada
	IDstudent NUMBER(9) UNIQUE, -- identifikator studenta koji je predlo?io i/ili zauzeo temu
	flagCustom NUMBER(1, 0) NOT NULL, -- zastavica koja ozna?ava je li prijedlog unaprijed zadan (ukoliko student zauzme temu, automatski pro?e kao njegov) ili ga je student predlo?io (osoba s ovlastima mora potvrditi validitet teme)
	constraint PRIJEDLOZI_ZAVRSNI_PK PRIMARY KEY (ID), -- postavljanje identifikatora kao primarni klju? tablice
    constraint PRIJEDLOZI_ZAVRSNI_F_CHECK check (flagCustom between 0 and 1)); -- pseudo-boolean constraint

CREATE sequence PRIJEDLOZI_ZAVRSNI_ID_SEQ; -- broja? identifikatora

CREATE trigger BI_PRIJEDLOZI_ZAVRSNI_ID -- inkrementator identifikatora
  before insert on prijedlozi_zavrsni
  for each row
begin
  select PRIJEDLOZI_ZAVRSNI_ID_SEQ.nextval into :NEW.ID from dual;
end;

/

ALTER TABLE zavrsni_radovi ADD CONSTRAINT zavrsni_radovi_fk0 FOREIGN KEY (IDprijedlog) REFERENCES prijedlozi_zavrsni(ID); -- primjena primarnog klju?a nad tablicom
ALTER TABLE zavrsni_radovi ADD CONSTRAINT zavrsni_radovi_fk1 FOREIGN KEY (IDpredmeti) REFERENCES predmeti_zavrsni(ID); -- primjena primarnog klju?a nad tablicom
ALTER TABLE zavrsni_radovi ADD CONSTRAINT zavrsni_radovi_fk2 FOREIGN KEY (IDprofesor) REFERENCES profesori_zavrsni(ID); -- primjena primarnog klju?a nad tablicom

ALTER TABLE prijedlozi_zavrsni ADD CONSTRAINT prijedlozi_zavrsni_fk0 FOREIGN KEY (IDstudent) REFERENCES studenti_zavrsni(ID); -- primjena primarnog klju?a nad tablicom

