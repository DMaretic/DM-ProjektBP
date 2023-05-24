CREATE OR REPLACE 
PACKAGE FILTER AS 

  function f_check_klijenti(in_json in JSON_OBJECT_T, out_json out JSON_OBJECT_T) return boolean;

END FILTER;