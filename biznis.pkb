CREATE OR REPLACE
PACKAGE BODY FILTER AS
e_iznimka exception;

  function f_check_klijenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean AS
      l_obj JSON_OBJECT_T;
      l_klijenti klijenti%rowtype;
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
        JSON_VALUE(l_string, '$.IME'),
        JSON_VALUE(l_string, '$.PREZIME' ),
        JSON_VALUE(l_string, '$.EMAIL' ),
        JSON_VALUE(l_string, '$.OIB' ),
        JSON_VALUE(l_string, '$.OVLASTI' ),
        JSON_VALUE(l_string, '$.SPOL' ),
        JSON_VALUE(l_string, '$.ZAPORKA' )
    INTO
        l_klijenti.id,
        l_klijenti.IME,
        l_klijenti.PREZIME,
        l_klijenti.EMAIL,
        l_klijenti.OIB,
        l_klijenti.OVLASTI,
        l_klijenti.SPOL,
        l_klijenti.PASSWORD
    FROM 
       dual; 
    
    if (nvl(l_klijenti.IME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite ime klijenta'); 
       l_obj.put('h_errcode', 101);
       raise e_iznimka;
    end if;
    
    if (nvl(l_klijenti.PREZIME, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite prezime klijenta'); 
       l_obj.put('h_errcode', 102);
       raise e_iznimka;
    end if;
    
    if (nvl(l_klijenti.EMAIL, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite email klijenta'); 
       l_obj.put('h_errcode', 103);
       raise e_iznimka;
    end if;
    
    if (nvl(l_klijenti.OIB, 0) = 0) then   
       l_obj.put('h_message', 'Molimo unesite OIB klijenta'); 
       l_obj.put('h_errcode', 104);
       raise e_iznimka;
    end if;
    
    if (nvl(l_klijenti.OVLASTI, 99) = 99) then   
       l_obj.put('h_message', 'Molimo odaberite ovlasti klijenta'); 
       l_obj.put('h_errcode', 105);
       raise e_iznimka;
    end if;
    
    if (nvl(l_klijenti.SPOL, 99) = 99) then   
       l_obj.put('h_message', 'Molimo unesite spol klijenta'); 
       l_obj.put('h_errcode', 106);
       raise e_iznimka;
    else
       if (l_klijenti.SPOL not in (0,1)) then
          l_obj.put('h_message', 'Spol može biti ili 0 ili 1'); 
          l_obj.put('h_errcode', 107);
          raise e_iznimka;
       end if;
    end if;
    
    
    
    if (nvl(l_klijenti.id,0) = 0 and nvl(l_klijenti.PASSWORD, ' ') = ' ') then   
       l_obj.put('h_message', 'Molimo unesite zaporku klijenta'); 
       l_obj.put('h_errcode', 108);
       raise e_iznimka;
    end if;
    
    out_json := l_obj;
    return false;
    
  EXCEPTION
     WHEN E_IZNIMKA THEN
        return true;
     WHEN OTHERS THEN
        COMMON.p_errlog('p_check_klijenti',dbms_utility.format_error_backtrace,SQLCODE,SQLERRM, l_string);
        l_obj.put('h_message', 'Dogodila se greška u obradi podataka!'); 
        l_obj.put('h_errcode', 109);
        out_json := l_obj;
        return true;
  END f_check_klijenti;

END FILTER;