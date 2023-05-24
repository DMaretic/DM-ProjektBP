create or replace NONEDITIONABLE PACKAGE ROUTER AS 
 e_iznimka exception;
    
 procedure p_main(p_in in varchar2, p_out out varchar2);

END ROUTER;


create or replace NONEDITIONABLE PACKAGE BODY ROUTER AS

  procedure p_main(p_in in varchar2, p_out out varchar2) AS
    l_obj JSON_OBJECT_T;
    l_procedura varchar2(40);
  BEGIN
    l_obj := JSON_OBJECT_T(p_in);

    SELECT
        JSON_VALUE(p_in, '$.procedura' RETURNING VARCHAR2)
    INTO
        l_procedura
    FROM DUAL;

    CASE l_procedura
    WHEN 'p_get_studenti' THEN
        dohvat.p_get_studenti(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_get_profesori' THEN
        dohvat.p_get_profesori(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_get_predmeti' THEN
        dohvat.p_get_predmeti(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_get_prijedlozi' THEN
        dohvat.p_get_prijedlozi(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_get_radovi' THEN
        dohvat.p_get_radovi(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_login' THEN
        dohvat.p_login(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_change_student' THEN
        podaci.p_change_student(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_change_profesor' THEN
        podaci.p_change_profesor(JSON_OBJECT_T(p_in), l_obj);     
    WHEN 'p_change_predmet' THEN
        podaci.p_change_predmet(JSON_OBJECT_T(p_in), l_obj);     
    WHEN 'p_change_prijedlog' THEN
        podaci.p_change_prijedlog(JSON_OBJECT_T(p_in), l_obj);     
    WHEN 'p_change_rad' THEN
        podaci.p_change_rad(JSON_OBJECT_T(p_in), l_obj);     
    ELSE
        l_obj.put('h_message', ' Nepoznata metoda ' || l_procedura);
        l_obj.put('h_errcode', 997);
    END CASE;
    p_out := l_obj.TO_STRING;
  END p_main;
END ROUTER;



















CREATE OR REPLACE PACKAGE FILTER AS 

  function f_check_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;

END FILTER;

--

create or replace NONEDITIONABLE PACKAGE BODY FILTER AS
e_iznimka exception;

  function f_check_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_studenti studenti_zavrsni%rowtype;
      l_nonunique number;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID'),
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
        l_studenti.id,
        l_studenti.IME,
        l_studenti.PREZIME,
        l_studenti.ZAPORKA,
        l_studenti.EMAIL
    FROM 
       dual; 

    if (nvl(l_studenti.IME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite ime'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    if (nvl(l_studenti.PREZIME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite prezime'); 
       l_obj.put('h_errcode', 102);
       raise e_iznimka;
    end if;

    if (nvl(l_studenti.EMAIL, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite email'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;


    if nvl(l_studenti.ZAPORKA, ' ') = ' ' then   
       l_obj.put('h_message', 'Molimo unesite zaporku'); 
       l_obj.put('h_errcode', 108);
       raise e_iznimka;
    end if;

    select
        count(1)
    into
        l_nonunique
    from
        studenti_zavrsni
    where
        l_studenti.EMAIL = EMAIL and
        l_studenti.id != ID;

    if l_nonunique > 0 then
        l_obj.put('h_message', 'Uneseni email nije unikatan'); 
        l_obj.put('h_errcode', 123);
        raise e_iznimka;
    end if;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_studenti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_studenti;

  function f_check_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_profesori profesori_zavrsni%rowtype;
      l_nonunique number;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID'),
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
        l_profesori.id,
        l_profesori.IME,
        l_profesori.PREZIME,
        l_profesori.ZAPORKA,
        l_profesori.EMAIL
    FROM 
       dual; 

    if (nvl(l_profesori.IME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite ime'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    if (nvl(l_profesori.PREZIME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite prezime'); 
       l_obj.put('h_errcode', 102);
       raise e_iznimka;
    end if;

    if (nvl(l_profesori.EMAIL, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite email'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;

    if nvl(l_profesori.ZAPORKA, ' ') = ' ' then   
       l_obj.put('h_message', 'Molimo unesite zaporku'); 
       l_obj.put('h_errcode', 108);
       raise e_iznimka;
    end if;

    select
        count(1)
    into
        l_nonunique
    from
        profesori_zavrsni
    where
        l_profesori.EMAIL = EMAIL and
        l_profesori.id != ID;

    if l_nonunique > 0 then
        l_obj.put('h_message', 'Uneseni email nije unikatan'); 
        l_obj.put('h_errcode', 123);
        raise e_iznimka;
    end if;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_profesori',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_profesori;

  function f_check_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_predmeti predmeti_zavrsni%rowtype;
      l_nonunique number;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.NAZIV')
    INTO
        l_predmeti.NAZIV
    FROM 
       dual; 

    if (nvl(l_predmeti.NAZIV, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite naziv'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_predmeti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_predmeti;

  function f_check_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_prijedlozi prijedlozi_zavrsni%rowtype;
      l_nonunique number;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID'),
        JSON_VALUE(l_string, '$.NAZIV'),
        JSON_VALUE(l_string, '$.IDSTUDENT'),
        JSON_VALUE(l_string, '$.FLAGCUSTOM')
    INTO
        l_prijedlozi.id,
        l_prijedlozi.NAZIV,
        l_prijedlozi.IDSTUDENT,
        l_prijedlozi.FLAGCUSTOM
    FROM 
       dual; 

    if (nvl(l_prijedlozi.NAZIV, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite naziv'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    if l_prijedlozi.IDSTUDENT is not null then
        select
        count(1)
    into
        l_nonunique
    from
        prijedlozi_zavrsni
    where
        l_prijedlozi.IDSTUDENT = IDSTUDENT and
        l_prijedlozi.id != ID;

    if l_nonunique > 0 then
        l_obj.put('h_message', 'Uneseni student je ve? zadan'); 
        l_obj.put('h_errcode', 124);
        raise e_iznimka;
    end if;
    end if;

    if (l_prijedlozi.FLAGCUSTOM is null) then   
       l_obj.put('h_message', 'Molimo unesite zastavicu'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_prijedlozi',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_prijedlozi;

  function f_check_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_radovi zavrsni_radovi%rowtype;
      l_nonunique number;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ID'),
        JSON_VALUE(l_string, '$.IDPRIJEDLOG'),
        JSON_VALUE(l_string, '$.IDPREDMETI'),
        JSON_VALUE(l_string, '$.IDPROFESOR')
    INTO
        l_radovi.id,
        l_radovi.IDPRIJEDLOG,
        l_radovi.IDPREDMETI,
        l_radovi.IDPROFESOR
    FROM 
       dual; 

    if (l_radovi.IDPRIJEDLOG is null) then   
       l_obj.put('h_message', 'Molimo unesite id prijedloga'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;

    if (l_radovi.IDPREDMETI is null) then   
       l_obj.put('h_message', 'Molimo unesite id predmeta'); 
       l_obj.put('h_errcode', 102);
       raise e_iznimka;
    end if;

    if (l_radovi.IDPROFESOR is null) then   
       l_obj.put('h_message', 'Molimo unesite id profesora'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;

    select
        count(1)
    into
        l_nonunique
    from
        zavrsni_radovi
    where
        l_radovi.IDPRIJEDLOG = IDPRIJEDLOG and
        l_radovi.id != ID;

    if l_nonunique > 0 then
        l_obj.put('h_message', 'Uneseni prijedlog je ve? postoje?i'); 
        l_obj.put('h_errcode', 124);
        raise e_iznimka;
    end if;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_radovi',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_radovi;

END FILTER;















CREATE OR REPLACE PACKAGE BIZNIS AS 

  function f_check_studentlogin(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_profesorlogin(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;

END BIZNIS;


create or replace NONEDITIONABLE PACKAGE BODY BIZNIS AS
e_iznimka exception;

  function f_check_studentlogin(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_email studenti_zavrsni.email%type;
      l_zaporka studenti_zavrsni.zaporka%type;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
        l_zaporka,
        l_email
    FROM 
       dual; 

    if (nvl(l_email, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite email'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;

    if nvl(l_zaporka, ' ') = ' ' then   
       l_obj.put('h_message', 'Molimo unesite zaporku'); 
       l_obj.put('h_errcode', 108);
       raise e_iznimka;
    end if;
    
    begin
        select 
         id
        into
        l_id
        from
        studenti_zavrsni
        where
        email = l_email and
        zaporka = l_zaporka;
        
        exception 
            when no_data_found then
            l_obj.put('h_message', 'Nepostoje?a kombinacija email-a i zaporke'); 
            l_obj.put('h_errcode', 108);
            raise e_iznimka;
            when others then
            raise;
    end;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_studentlogin',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_studentlogin;


    function f_check_profesorlogin(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_email profesori_zavrsni.email%type;
      l_zaporka profesori_zavrsni.zaporka%type;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;

     SELECT
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
        l_zaporka,
        l_email
    FROM 
       dual; 

    if (nvl(l_email, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite email'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;

    if nvl(l_zaporka, ' ') = ' ' then   
       l_obj.put('h_message', 'Molimo unesite zaporku'); 
       l_obj.put('h_errcode', 108);
       raise e_iznimka;
    end if;
    
    begin
        select 
         id
        into
        l_id
        from
        profesori_zavrsni
        where
        email = l_email and
        zaporka = l_zaporka;
        
        exception 
            when no_data_found then
            l_obj.put('h_message', 'Nepostoje?a kombinacija email-a i zaporke'); 
            l_obj.put('h_errcode', 108);
            raise e_iznimka;
            when others then
            raise;
    end;

    out_json := l_obj;
    return false;

  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('f_check_profesorlogin',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_profesorlogin;
END BIZNIS;

commit;