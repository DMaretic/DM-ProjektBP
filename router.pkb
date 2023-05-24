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
    WHEN 'p_get_zupanije' THEN
        dohvat.p_get_zupanije(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_login' THEN
        dohvat.p_login(JSON_OBJECT_T(p_in), l_obj);
    WHEN 'p_get_klijenti' THEN
        dohvat.p_get_klijenti(JSON_OBJECT_T(p_in), l_obj); 
    WHEN 'p_save_klijenti' THEN
        spremi.p_save_klijenti(JSON_OBJECT_T(p_in), l_obj);     
    ELSE
        l_obj.put('h_message', ' Nepoznata metoda ' || l_procedura);
        l_obj.put('h_errcode', 997);
    END CASE;
    p_out := l_obj.TO_STRING;
  END p_main;
END ROUTER;