CREATE OR REPLACE
PACKAGE BODY FILTER AS
e_iznimka exception;

  function f_check_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_studenti studenti_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;
  
     SELECT
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
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
    
    out_json := l_obj;
    return false;
    
  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('p_check_studenti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_studenti;
  
  function f_check_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_profesori profesori_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;
  
     SELECT
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.ZAPORKA' ),
        JSON_VALUE(l_string, '$.EMAIL' )
    INTO
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
    
    out_json := l_obj;
    return false;
    
  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('p_check_profesori',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_profesori;
  
  function f_check_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_predmeti predmeti_zavrsni%rowtype;
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
    
    if (nvl(l_predmeti.naziv, ' ') = ' ') then   
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
        COMMON.p_errlog('p_check_predmeti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_predmeti;
  
  function f_check_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_prijedlozi prijedlozi_zavrsni%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;
  
     SELECT
        JSON_VALUE(l_string, '$.NAZIV'),
        JSON_VALUE(l_string, '$.IDSTUDENT'),
        JSON_VALUE(l_string, '$.FLAGCUSTOM')
    INTO
        l_prijedlozi.NAZIV,
        l_prijedlozi.IDSTUDENT,
        l_prijedlozi.FLAGCUSTOM
    FROM 
       dual; 
    
    if (nvl(l_prijedlozi.naziv, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite naziv'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;
    
    if (nvl(l_prijedlozi.flagcustom, ' ') = ' ') then   
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
        COMMON.p_errlog('p_check_predmeti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_prijedlozi;
  
  function f_check_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_radovi zavrsni_radovi%rowtype;
      l_count number;
      l_id number;
      l_string varchar2(1000);
  BEGIN
     l_obj := JSON_OBJECT_T(in_json);  
     l_string := in_json.TO_STRING;
  
     SELECT
        JSON_VALUE(l_string, '$.IDPRIJEDLOG'),
        JSON_VALUE(l_string, '$.IDPREDMETI'),
        JSON_VALUE(l_string, '$.IDPROFESOR')
    INTO
        l_radovi.IDPRIJEDLOG,
        l_radovi.IDPREDMETI,
        l_radovi.IDPROFESOR
    FROM 
       dual; 
    
    if (nvl(l_radovi.idprijedlog, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite id prijedloga'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;
    
    if (nvl(l_radovi.idpredmeti, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite id predmeta'); 
       l_obj.put('h_errcode', 102);
       raise e_iznimka;
    end if;
    
    if (nvl(l_radovi.idprofesor, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite id profesora'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;
    
    out_json := l_obj;
    return false;
    
  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('p_check_radovi',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greska u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_radovi;

END FILTER;