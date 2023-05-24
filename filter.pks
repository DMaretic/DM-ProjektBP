CREATE OR REPLACE NONEDITIONABLE PACKAGE FILTER AS 

  function f_check_studenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_profesori(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_predmeti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_prijedlozi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;
  function f_check_radovi(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;

END FILTER;