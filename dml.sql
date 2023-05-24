create or replace NONEDITIONABLE PACKAGE DOHVAT AS 

  procedure p_get_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_get_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_get_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_get_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_get_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_login(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
  procedure p_login_student(in_json in json_object_t, out_json out json_object_t);
  procedure p_login_profesor(in_json in json_object_t, out_json out json_object_t);

END DOHVAT;


create or replace NONEDITIONABLE PACKAGE BODY DOHVAT AS
e_iznimka exception;
------------------------------------------------------------------------------------
  procedure p_get_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
  l_obj JSON_OBJECT_T;
  l_studenti json_array_t :=JSON_ARRAY_T('[]');
  l_count number;
  l_id number;
  l_string varchar2(1000);
  l_search varchar2(100);
  l_page number; 
  l_perpage number; 
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);

    l_string := in_json.TO_STRING; 

    SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.search'),
        JSON_VALUE(l_string, '$.page' ),
        JSON_VALUE(l_string, '$.perpage' )
    INTO
        l_id,
        l_search,
        l_page,
        l_perpage
    FROM 
       dual;

    FOR x IN (
            SELECT 
               json_object('ID' VALUE ID, 
                           'IME' VALUE IME,
                           'PREZIME' VALUE PREZIME,
                           'ZAPORKA' VALUE ZAPORKA,
                           'EMAIL' VALUE EMAIL) as izlaz
             FROM
                studenti_zavrsni
             where
                ID = nvl(l_id, ID) and (
                upper(ime) like nvl('%' || upper(l_search) || '%', upper(ime)) or
                upper(prezime) like nvl('%' || upper(l_search) || '%', upper(prezime)))
                OFFSET NVL(l_page,0)*NVL(l_perpage,10) ROWS FETCH NEXT NVL(l_perpage,10) ROWS ONLY  
            )
        LOOP
            l_studenti.append(JSON_OBJECT_T(x.izlaz));
        END LOOP;

    SELECT
      count(1)
    INTO
       l_count
    FROM 
       studenti_zavrsni;

    l_obj.put('count',l_count);
    l_obj.put('data',l_studenti);
    out_json := l_obj;
    
    EXCEPTION
   WHEN OTHERS THEN
       common.p_errlog('p_get_studenti', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;    

  END p_get_studenti;

------------------------------------------------------------------------------------

  procedure p_get_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
  l_obj JSON_OBJECT_T;
  l_profesori json_array_t :=JSON_ARRAY_T('[]');
  l_count number;
  l_id number;
  l_string varchar2(1000);
  l_search varchar2(100);
  l_page number; 
  l_perpage number; 
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);

    l_string := in_json.TO_STRING; 

    SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.search'),
        JSON_VALUE(l_string, '$.page' ),
        JSON_VALUE(l_string, '$.perpage' )
    INTO
        l_id,
        l_search,
        l_page,
        l_perpage
    FROM 
       dual;

    FOR x IN (
            SELECT 
               json_object('ID' VALUE ID, 
                           'IME' VALUE IME,
                           'PREZIME' VALUE PREZIME,
                           'ZAPORKA' VALUE ZAPORKA,
                           'EMAIL' VALUE EMAIL) as izlaz
             FROM
                profesori_zavrsni
             where
                ID = nvl(l_id, ID) and (
                upper(ime) like nvl('%' || upper(l_search) || '%', upper(ime)) or
                upper(prezime) like nvl('%' || upper(l_search) || '%', upper(prezime)))
                OFFSET NVL(l_page,0)*NVL(l_perpage,10) ROWS FETCH NEXT NVL(l_perpage,10) ROWS ONLY
            )
        LOOP
            l_profesori.append(JSON_OBJECT_T(x.izlaz));
        END LOOP;

    SELECT
      count(1)
    INTO
       l_count
    FROM 
       profesori_zavrsni;

    l_obj.put('count',l_count);
    l_obj.put('data',l_profesori);
    out_json := l_obj;
    
    EXCEPTION
   WHEN OTHERS THEN
       common.p_errlog('p_get_profesori', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;    

  END p_get_profesori;
  
  
  procedure p_get_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
  l_obj JSON_OBJECT_T;
  l_predmeti json_array_t :=JSON_ARRAY_T('[]');
  l_count number;
  l_id number;
  l_string varchar2(1000);
  l_search varchar2(100);
  l_page number; 
  l_perpage number; 
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);

    l_string := in_json.TO_STRING; 

    SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.search'),
        JSON_VALUE(l_string, '$.page' ),
        JSON_VALUE(l_string, '$.perpage' )
    INTO
        l_id,
        l_search,
        l_page,
        l_perpage
    FROM 
       dual;

    FOR x IN (
            SELECT 
               json_object('ID' VALUE ID, 
                           'NAZIV' VALUE NAZIV) as izlaz
             FROM
                predmeti_zavrsni
             where
                ID = nvl(l_id, ID) and
                upper(naziv) like nvl('%' || upper(l_search) || '%', upper(naziv))
                OFFSET NVL(l_page,0)*NVL(l_perpage,10) ROWS FETCH NEXT NVL(l_perpage,10) ROWS ONLY
            )
        LOOP
            l_predmeti.append(JSON_OBJECT_T(x.izlaz));
        END LOOP;

    SELECT
      count(1)
    INTO
       l_count
    FROM 
       predmeti_zavrsni;

    l_obj.put('count',l_count);
    l_obj.put('data',l_predmeti);
    out_json := l_obj;
    
    EXCEPTION
   WHEN OTHERS THEN
       common.p_errlog('p_get_predmeti', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;    

  END p_get_predmeti;
  
  
  procedure p_get_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
  l_obj JSON_OBJECT_T;
  l_prijedlozi json_array_t :=JSON_ARRAY_T('[]');
  l_count number;
  l_id number;
  l_string varchar2(1000);
  l_search varchar2(100);
  l_page number; 
  l_perpage number; 
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);

    l_string := in_json.TO_STRING; 

    SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.search'),
        JSON_VALUE(l_string, '$.page' ),
        JSON_VALUE(l_string, '$.perpage' )
    INTO
        l_id,
        l_search,
        l_page,
        l_perpage
    FROM 
       dual;

    FOR x IN (
            SELECT 
               json_object('ID' VALUE ID, 
                           'NAZIV' VALUE NAZIV,
                           'IDSTUDENT' VALUE IDSTUDENT,
                           'FLAGCUSTOM' VALUE FLAGCUSTOM) as izlaz
             FROM
                prijedlozi_zavrsni
             where
                ID = nvl(l_id, ID) and (
                upper(naziv) like nvl('%' || upper(l_search) || '%', upper(naziv)) or
                upper(idstudent) like nvl('%' || upper(l_search) || '%', upper(idstudent)))
                OFFSET NVL(l_page,0)*NVL(l_perpage,10) ROWS FETCH NEXT NVL(l_perpage,10) ROWS ONLY  
            )
        LOOP
            l_prijedlozi.append(JSON_OBJECT_T(x.izlaz));
        END LOOP;

    SELECT
      count(1)
    INTO
       l_count
    FROM 
       prijedlozi_zavrsni;

    l_obj.put('count',l_count);
    l_obj.put('data',l_prijedlozi);
    out_json := l_obj;
    
    EXCEPTION
   WHEN OTHERS THEN
       common.p_errlog('p_get_prijedlozi', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;    

  END p_get_prijedlozi;
  
  
  procedure p_get_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
  l_obj JSON_OBJECT_T;
  l_radovi json_array_t :=JSON_ARRAY_T('[]');
  l_count number;
  l_id number;
  l_string varchar2(1000);
  l_search varchar2(100);
  l_page number; 
  l_perpage number; 
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);

    l_string := in_json.TO_STRING; 

    SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.search'),
        JSON_VALUE(l_string, '$.page' ),
        JSON_VALUE(l_string, '$.perpage' )
    INTO
        l_id,
        l_search,
        l_page,
        l_perpage
    FROM 
       dual;

    FOR x IN (
            SELECT 
               json_object('ID' VALUE ID, 
                           'IDPRIJEDLOG' VALUE IDPRIJEDLOG, 
                           'IDPREDMETI' VALUE IDPREDMETI, 
                           'IDPROFESOR' VALUE IDPROFESOR ) as izlaz
             FROM
                zavrsni_radovi
             where
                ID = nvl(l_id, ID) and (
                upper(IDPRIJEDLOG) like nvl('%' || upper(l_search) || '%', upper(IDPRIJEDLOG)) OR
                upper(IDPREDMETI) like nvl('%' || upper(l_search) || '%', upper(IDPREDMETI)) OR
                upper(IDPROFESOR) like nvl('%' || upper(l_search) || '%', upper(IDPROFESOR))
                )
                OFFSET NVL(l_page,0)*NVL(l_perpage,10) ROWS FETCH NEXT NVL(l_perpage,10) ROWS ONLY  
            )
        LOOP
            l_radovi.append(JSON_OBJECT_T(x.izlaz));
        END LOOP;

    SELECT
      count(1)
    INTO
       l_count
    FROM 
       zavrsni_radovi;

    l_obj.put('count',l_count);
    l_obj.put('data',l_radovi);
    out_json := l_obj;
    
    EXCEPTION
   WHEN OTHERS THEN
       common.p_errlog('p_get_radovi', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;    

  END p_get_radovi;

------------------------------------------------------------------------------------

 procedure p_login(in_json in json_object_t, out_json out json_object_t) as 
    l_obj json_object_t;
    l_string varchar2(4000);
    l_type number;
    begin
        l_string:=in_json.to_string;
    SELECT
        JSON_VALUE(l_string, '$.TIP' )
    INTO
        l_type
    FROM 
       dual;
    
        if(l_type = 1) then
        dohvat.p_login_student(in_json,out_json);
        else
        dohvat.p_login_profesor(in_json,out_json);
        end if;
    end p_login;

 PROCEDURE p_login_student(in_json in json_object_t, out_json out json_object_t )AS
    l_obj        json_object_t := json_object_t();
    l_input      VARCHAR2(4000);
    l_record     VARCHAR2(4000);
    l_username   studenti_zavrsni.email%TYPE;
    l_password   studenti_zavrsni.zaporka%TYPE;
    l_id         studenti_zavrsni.id%TYPE;
    l_out        json_array_t := json_array_t('[]');
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);
    l_input := in_json.to_string;
    SELECT
        JSON_VALUE(l_input, '$.EMAIL' RETURNING VARCHAR2),
        JSON_VALUE(l_input, '$.ZAPORKA' RETURNING VARCHAR2)
    INTO
        l_username,
        l_password
    FROM
        dual;

    IF (biznis.f_check_studentlogin(in_json, out_json)) THEN
       l_obj.put('h_message', 'Molimo unesite korisni?ko ime i zaporku');
       l_obj.put('h_errcod', 101);
       RAISE e_iznimka;
    ELSE
       BEGIN
          SELECT
             id
          INTO 
             l_id
          FROM
             studenti_zavrsni
          WHERE
             email = l_username AND 
             zaporka = l_password;
       END;

       SELECT
          JSON_OBJECT( 
             'ID' VALUE kor.id, 
             'ime' VALUE kor.ime, 
             'prezime' VALUE kor.prezime,
             'email' VALUE kor.email, 
             'ovlasti' VALUE 0)
       INTO 
          l_record
       FROM
          studenti_zavrsni kor
       WHERE
          id = l_id;

    END IF;

    l_out.append(json_object_t(l_record));
    l_obj.put('data', l_out);
    out_json := l_obj;
 EXCEPTION
    WHEN e_iznimka THEN
       out_json := l_obj; 
    WHEN OTHERS THEN
       common.p_errlog('p_login_student', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_input);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;
 END p_login_student;

  
   PROCEDURE p_login_profesor(in_json in json_object_t, out_json out json_object_t )AS
    l_obj        json_object_t := json_object_t();
    l_input      VARCHAR2(4000);
    l_record     VARCHAR2(4000);
    l_username   profesori_zavrsni.email%TYPE;
    l_password   profesori_zavrsni.zaporka%TYPE;
    l_id         profesori_zavrsni.id%TYPE;
    l_out        json_array_t := json_array_t('[]');
 BEGIN
    l_obj := JSON_OBJECT_T(in_json);
    l_input := in_json.to_string;
    SELECT
        JSON_VALUE(l_input, '$.EMAIL' RETURNING VARCHAR2),
        JSON_VALUE(l_input, '$.ZAPORKA' RETURNING VARCHAR2)
    INTO
        l_username,
        l_password
    FROM
        dual;

    IF (biznis.f_check_profesorlogin(in_json, out_json)) THEN
       RAISE e_iznimka;
    ELSE
       BEGIN
          SELECT
             id
          INTO 
             l_id
          FROM
             profesori_zavrsni
          WHERE
             email = l_username AND 
             zaporka = l_password;
       END;

       SELECT
          JSON_OBJECT( 
             'ID' VALUE kor.id, 
             'ime' VALUE kor.ime, 
             'prezime' VALUE kor.prezime,
             'email' VALUE kor.email, 
             'ovlasti' VALUE 0)
       INTO 
          l_record
       FROM
          profesori_zavrsni kor
       WHERE
          id = l_id;

    END IF;

    l_out.append(json_object_t(l_record));
    l_obj.put('data', l_out);
    out_json := l_obj;
 EXCEPTION
    WHEN e_iznimka THEN
       out_json := l_obj; 
    WHEN OTHERS THEN
       common.p_errlog('p_login_profesor', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_input);
       l_obj.put('h_message', 'Gre?ka u obradi podataka');
       l_obj.put('h_errcode', 99);
       ROLLBACK;
 END p_login_profesor;

END DOHVAT;


SET SERVEROUTPUT ON;
DECLARE
l_obj json_object_t;
l_out json_object_t;
BEGIN
l_obj := json_object_t.parse  ( '{"perpage":20}');
DOHVAT.p_get_studenti(l_obj,l_out);
DBMS_OUTPUT.put_line(l_out.to_string);
END;




















create or replace NONEDITIONABLE PACKAGE PODACI AS 

 procedure p_change_student(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
 procedure p_change_profesor(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
 procedure p_change_predmet(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
 procedure p_change_prijedlog(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
 procedure p_change_rad(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T);
 

END PODACI;



create or replace NONEDITIONABLE PACKAGE BODY PODACI AS
e_iznimka exception;


  procedure p_change_student(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
      l_obj JSON_OBJECT_T;
      l_studenti studenti_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
      l_search varchar2(100);
      l_page number; 
      l_perpage number;
      l_action varchar2(10);
  begin

     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.EMAIL' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.ACTION' )
    INTO
        l_studenti.id,
        l_studenti.IME,
        l_studenti.PREZIME,
        l_studenti.EMAIL,
        l_studenti.ZAPORKA,
        l_action
    FROM 
       dual; 

    if (nvl(l_action, ' ') = ' ') then
        if (filter.f_check_studenti(l_obj, out_json)) then
           raise e_iznimka; 
        end if;  
    end if;

    if (l_studenti.id is null) then
        begin
           insert into studenti_zavrsni (IME, PREZIME, EMAIL, ZAPORKA) values
             (l_studenti.IME, l_studenti.PREZIME,
              l_studenti.EMAIL, l_studenti.ZAPORKA);
           commit;

           l_obj.put('h_message', 'Uspje?no ste unijeli studenta'); 
           l_obj.put('h_errcode', 0);
           out_json := l_obj;

        exception
           when others then 
               COMMON.p_errlog('p_change_student',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
               rollback;
               raise;
        end;
    else
        begin
        select
            count(1)
        into
            l_count
        from
            studenti_zavrsni
        where
            l_studenti.id = id;
            
        if l_count = 0 then
            l_obj.put('h_message', 'Uneseni ID ne postoji'); 
            l_obj.put('h_errcode', 0);
            out_json := l_obj;
            raise e_iznimka;
        end if;
            
        end;
       if (nvl(l_action, ' ') = 'delete') then
           begin
               update prijedlozi_zavrsni
               set idstudent = null
               where idstudent = l_studenti.id and flagcustom = 0;
               delete from prijedlozi_zavrsni
               where idstudent = l_studenti.id and flagcustom = 1;
               delete from studenti_zavrsni where id = l_studenti.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste obrisali studenta'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_student',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;

       else

           begin
               update studenti_zavrsni
                  set IME = l_studenti.IME,
                      PREZIME = l_studenti.PREZIME,
                      EMAIL = l_studenti.EMAIL,
                      ZAPORKA = l_studenti.ZAPORKA
               where
                  id = l_studenti.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste promijenili studenta'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_check_student',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;
       end if;     
    end if;


  exception
     when e_iznimka then
        out_json := l_obj; 
     when others then
        COMMON.p_errlog('p_change_student',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se gre?ka u obradi podataka!'); 
        l_obj.put('h_errcode', 101);
        out_json := l_obj;
  END p_change_student;

    procedure p_change_profesor(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
      l_obj JSON_OBJECT_T;
      l_profesori profesori_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
      l_search varchar2(100);
      l_page number; 
      l_perpage number;
      l_action varchar2(10);
  begin

     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.EMAIL' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.ACTION' )
    INTO
        l_profesori.id,
        l_profesori.IME,
        l_profesori.PREZIME,
        l_profesori.EMAIL,
        l_profesorI.ZAPORKA,
        l_action
    FROM 
       dual; 

    if (nvl(l_action, ' ') = ' ') then
        if (filter.f_check_profesori(l_obj, out_json)) then
           raise e_iznimka; 
        end if;  
    end if;

    if (l_profesori.id is null) then
        begin
           insert into profesori_zavrsni (IME, PREZIME, EMAIL, ZAPORKA) values
             (l_profesori.IME, l_profesori.PREZIME,
              l_profesori.EMAIL, l_profesori.ZAPORKA);
           commit;

           l_obj.put('h_message', 'Uspje?no ste unijeli profesora'); 
           l_obj.put('h_errcode', 0);
           out_json := l_obj;

        exception
           when others then 
               COMMON.p_errlog('p_change_profesor',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
               rollback;
               raise;
        end;
    else
        begin
        select
            count(1)
        into
            l_count
        from
            profesori_zavrsni
        where
            l_profesori.id = id;
            
        if l_count = 0 then
            l_obj.put('h_message', 'Uneseni ID ne postoji'); 
            l_obj.put('h_errcode', 0);
            out_json := l_obj;
            raise e_iznimka;
        end if;
            
        end;
       if (nvl(l_action, ' ') = 'delete') then
           begin
               delete from zavrsni_radovi where idprofesor = l_profesori.id;
               delete from profesori_zavrsni where id = l_profesori.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste obrisali profesora'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_profesor',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;

       else

           begin
               update profesori_zavrsni
                  set IME = l_profesori.IME,
                      PREZIME = l_profesori.PREZIME,
                      EMAIL = l_profesori.EMAIL,
                      ZAPORKA = l_profesori.ZAPORKA
               where
                  id = l_profesori.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste promijenili profesora'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_profesor',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;
       end if;     
    end if;


  exception
     when e_iznimka then
        out_json := l_obj; 
     when others then
        COMMON.p_errlog('p_change_profesor',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se gre?ka u obradi podataka!'); 
        l_obj.put('h_errcode', 101);
        out_json := l_obj;
  END p_change_profesor;

    procedure p_change_predmet(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
      l_obj JSON_OBJECT_T;
      l_predmeti predmeti_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
      l_search varchar2(100);
      l_page number; 
      l_perpage number;
      l_action varchar2(10);
  begin

     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.NAZIV'),
        JSON_VALUE(l_string, '$.ACTION' )
    INTO
        l_predmeti.id,
        l_predmeti.NAZIV,
        l_action
    FROM 
       dual; 

    if (nvl(l_action, ' ') = ' ') then
        if (filter.f_check_predmeti(l_obj, out_json)) then
           raise e_iznimka; 
        end if;  
    end if;

    if (l_predmeti.id is null) then
        begin
           insert into predmeti_zavrsni (NAZIV) values
             (l_predmeti.NAZIV);
           commit;

           l_obj.put('h_message', 'Uspje?no ste unijeli predmet'); 
           l_obj.put('h_errcode', 0);
           out_json := l_obj;

        exception
           when others then 
               COMMON.p_errlog('p_change_predmet',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
               rollback;
               raise;
        end;
        else
        begin
        select
            count(1)
        into
            l_count
        from
            predmeti_zavrsni
        where
            l_predmeti.id = id;
            
        if l_count = 0 then
            l_obj.put('h_message', 'Uneseni ID ne postoji'); 
            l_obj.put('h_errcode', 0);
            out_json := l_obj;
            raise e_iznimka;
        end if;
            
        end;
       if (nvl(l_action, ' ') = 'delete') then
           begin
               delete from zavrsni_radovi where idpredmeti = l_predmeti.id;
               delete from predmeti_zavrsni where id = l_predmeti.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste obrisali predmet'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_predmet',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;

       else

           begin
               update predmeti_zavrsni
                  set NAZIV = l_predmeti.NAZIV
               where
                  id = l_predmeti.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste promijenili predmet'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_predmet',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;
       end if;     
    end if;


  exception
     when e_iznimka then
        out_json := l_obj; 
     when others then
        COMMON.p_errlog('p_change_predmet',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se gre?ka u obradi podataka!'); 
        l_obj.put('h_errcode', 101);
        out_json := l_obj;
  END p_change_predmet;

    procedure p_change_prijedlog(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
      l_obj JSON_OBJECT_T;
      l_prijedlozi prijedlozi_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
      l_search varchar2(100);
      l_page number; 
      l_perpage number;
      l_action varchar2(10);
  begin

     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.NAZIV'),
        JSON_VALUE(l_string, '$.IDSTUDENT' ),
        JSON_VALUE(l_string, '$.FLAGCUSTOM' ),
        JSON_VALUE(l_string, '$.ACTION' )
    INTO
        l_prijedlozi.id,
        l_prijedlozi.NAZIV,
        l_prijedlozi.IDSTUDENT,
        l_prijedlozi.FLAGCUSTOM,
        l_action
    FROM 
       dual; 

    if (nvl(l_action, ' ') = ' ') then
        if (filter.f_check_prijedlozi(l_obj, out_json)) then
           raise e_iznimka; 
        end if;  
    end if;

    if (l_prijedlozi.id is null) then
        begin
           insert into prijedlozi_zavrsni (NAZIV, IDSTUDENT, FLAGCUSTOM) values
             (l_prijedlozi.NAZIV, l_prijedlozi.IDSTUDENT,
              l_prijedlozi.FLAGCUSTOM);
           commit;

           l_obj.put('h_message', 'Uspje?no ste unijeli prijedlog'); 
           l_obj.put('h_errcode', 0);
           out_json := l_obj;

        exception
           when others then 
               COMMON.p_errlog('p_change_prijedlog',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
               rollback;
               raise;
        end;
    else
       if (nvl(l_action, ' ') = 'delete') then
           begin
               delete from zavrsni_radovi where idprijedlog = l_prijedlozi.id;
               delete from prijedlozi_zavrsni where id = l_prijedlozi.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste obrisali prijedlog'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_prijedlog',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;

       else

           begin
               update prijedlozi_zavrsni
                  set NAZIV = l_prijedlozi.NAZIV,
                      IDSTUDENT = l_prijedlozi.IDSTUDENT,
                      FLAGCUSTOM = l_prijedlozi.FLAGCUSTOM
               where
                  id = l_prijedlozi.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste promijenili prijedloG'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_prijedlog',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;
       end if;     
    end if;


  exception
     when e_iznimka then
        out_json := l_obj; 
     when others then
        COMMON.p_errlog('p_change_prijedlog',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se gre?ka u obradi podataka!'); 
        l_obj.put('h_errcode', 101);
        out_json := l_obj;
  END p_change_prijedlog;

    procedure p_change_rad(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) AS
      l_obj JSON_OBJECT_T;
      l_radovi zavrsni_radovi%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
      l_search varchar2(100);
      l_page number; 
      l_perpage number;
      l_action varchar2(10);
  begin

     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID' ),
        JSON_VALUE(l_string, '$.IDPRIJEDLOG'),
        JSON_VALUE(l_string, '$.IDPREDMETI' ),
        JSON_VALUE(l_string, '$.IDPROFESOR' ),
        JSON_VALUE(l_string, '$.ACTION' )
    INTO
        l_radovi.id,
        l_radovi.IDPRIJEDLOG,
        l_radovi.IDPREDMETI,
        l_radovi.IDPROFESOR,
        l_action
    FROM 
       dual; 

    if (nvl(l_action, ' ') = ' ') then
        if (filter.f_check_radovi(l_obj, out_json)) then
           raise e_iznimka; 
        end if;  
    end if;

    if (l_radovi.id is null) then
        begin
           insert into zavrsni_radovi (IDPRIJEDLOG, IDPREDMETI, IDPROFESOR) values
             (l_radovi.IDPRIJEDLOG, l_radovi.IDPREDMETI,
              l_radovi.IDPROFESOR);
           commit;

           l_obj.put('h_message', 'Uspje?no ste unijeli rad'); 
           l_obj.put('h_errcode', 0);
           out_json := l_obj;

        exception
           when others then 
               COMMON.p_errlog('p_change_rad',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
               rollback;
               raise;
        end;
        else
        begin
        select
            count(1)
        into
            l_count
        from
            zavrsni_radovi
        where
            l_radovi.id = id;
            
        if l_count = 0 then
            l_obj.put('h_message', 'Uneseni ID ne postoji'); 
            l_obj.put('h_errcode', 0);
            out_json := l_obj;
            raise e_iznimka;
        end if;
            
        end;
       if (nvl(l_action, ' ') = 'delete') then
           begin
               delete from zavrsni_radovi where id = l_radovi.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste obrisali rad'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_rad',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;

       else

           begin
               update zavrsni_radovi
                  set IDPRIJEDLOG = l_radovi.IDPRIJEDLOG,
                      IDPREDMETI = l_radovi.IDPREDMETI,
                      IDPROFESOR = l_radovi.IDPROFESOR
               where
                  id = l_radovi.id;
               commit;    

               l_obj.put('h_message', 'Uspje?no ste promijenili rad'); 
               l_obj.put('h_errcode', 0);
               out_json := l_obj;
            exception
               when others then 
                   COMMON.p_errlog('p_change_rad',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
                   rollback;
                   raise;
            end;
       end if;     
    end if;


  exception
     when e_iznimka then
        out_json := l_obj; 
     when others then
        COMMON.p_errlog('p_change_rad',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se gre?ka u obradi podataka!'); 
        l_obj.put('h_errcode', 101);
        out_json := l_obj;
  END p_change_rad;

END PODACI;


commit;