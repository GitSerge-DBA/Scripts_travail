CONN LEVSEDBA@ADMIN_P051/f0c0ns
SET ECHO OFF
SET VERIFY   OFF
SET PAGESIZE 1000
SET LONG 90000

ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '. ';
col "Base de  Données" 		format a20
col "Compte" 		format a12
col Total		format a12
col Total		format a12


set numformat "9,999,999,999.99"
alter session set nls_date_format = 'YYYY-MM-DD';


set TERMOUT off;
set feedback off;
SET UNDERLINE =



break on "Base de  Données" SKIP PAGE 
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Nbr sess." on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env." on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu" on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T" on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env. DBL"  on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu DBL" on "Base de  Données"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T DBL"  on "Base de  Données"
;


spool 'C:\Users\levse4\OneDrive - BuroVirtuel\Travail\GIT\Scripts_travail\Rapports_html\RAPP_HTML_&&1..HTML'

prompt <table border='1' width='95%' align='center' bgcolor="ffffcc" summary='Script output'>
prompt <tr> <th scope="col"> Statistiques pour &&1 pour 2024</th>  </tr>
prompt </table>

set markup HTML on HEAD "<style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;}  p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black;  background:#f7f7e7 ;     padding:0px 0px 0px 0px; margin:0px 0px 0px 0px;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White;  border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;}h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style><title>Rapport des essais de performances </title>"  BODY "" TABLE "border='1' width='95%' align='center' summary='Script output'"  SPOOL ON ENTMAP OFF  PRE OFF 

SELECT 
V.ACS_NOM_BASE  	   as "Base de  Données", 
CODE_UTILI_BD  		   as "Compte",
NB_SESS 			   as "Nbr sess.",
NBR_MEG_ENVOI_CLIEN    as "Meg env.", 
NBR_MEG_RECU_CLIEN     as "Meg reçu"	, 
NBR_ROUND_TRIP_CLIEN   as "R-T",  
NBR_MEG_ENVOI_DB_LINK  as "Meg env. DBL" , 
NBR_MEG_RECU_DB_LINK   as "Meg reçu DBL" , 
NBR_ROUND_TRIP_DB_LINK as "R-T DBL"  
FROM  DRI_AUDIT.DRI_AUDIT_CONNE_BD_STIBD_VUE V
WHERE  CODE_UTILI_BD LIKE '&&1%'
order by CODE_UTILI_BD;  


CLEAR BREAKS
CLEAR COMPUTES

prompt <table border='1' width='95%' align='center' bgcolor="ffffcc" summary='Script output'>
prompt <tr> <th scope="col"> Statistiques pour &&1 par mois </th>  </tr>
prompt </table>

break on "Base de  Données" SKIP PAGE on "Mois"
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Nbr sess." on "Base de  Données"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env." on "Base de  Données" 
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu" on "Base de  Données" 
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T" on "Base de  Données"  
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env. DBL"  on "Base de  Données" 
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu DBL" on "Base de  Données"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T DBL"  on "Base de  Données" 
COMPUTE  SUM LABEL Total  AVG LABEL Moyenne  MAX LABEL Maximum OF  "Nbr sess." on  "Mois"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env." on "Mois"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu" on "Mois" 
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T" on "Mois" 
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg env. DBL"  on "Mois"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "Meg reçu DBL" on "Mois"
COMPUTE SUM LABEL Total   AVG LABEL Moyenne  MAX LABEL Maximum OF  "R-T DBL"  on "Mois";


SELECT  
v.ACS_NOM_BASE  as "Base de  Données", 
ACS_DATE_LOGON as "Mois",
CODE_UTILI_BD  as "Compte",
NB_SESS AS "Nbr sess.",
NBR_MEG_ENVOI_CLIEN    as "Meg env.", 
NBR_MEG_RECU_CLIEN     as "Meg reçu"	, 
NBR_ROUND_TRIP_CLIEN   as "R-T",  
NBR_MEG_ENVOI_DB_LINK  as "Meg env. DBL" , 
NBR_MEG_RECU_DB_LINK   as "Meg reçu DBL" , 
NBR_ROUND_TRIP_DB_LINK as "R-T DBL"
FROM  DRI_AUDIT.DRI_AUDIT_CONNE_MMBD_STIBD_VUE V
WHERE  CODE_UTILI_BD LIKE '&&1%'
order by ACS_DATE_LOGON,CODE_UTILI_BD;  
  

CLEAR BREAKS
CLEAR COMPUTES

prompt <table border='1' width='95%' align='center' bgcolor="ffffcc" summary='Script output'>
prompt <tr> <th scope="col"> Statistiques pour &&1 par jour </th>  </tr>
prompt </table>


break on "Base de  Données" SKIP PAGE on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "Nbr sess." on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "Meg env." on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "Meg reçu" on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "R-T" on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "Meg env. DBL"  on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "Meg reçu DBL" on "Compte"
COMPUTE  SUM LABEL Total AVG LABEL Moyenne   MAX LABEL Maximum OF "R-T DBL"  on "Compte"


SELECT  
v.ACS_NOM_BASE  as "Base de  Données", 
CODE_UTILI_BD  as "Compte",
ACS_DATE_LOGON as "Jour",
NB_SESS AS "Nbr sess.",
TOT_MEG_ENVOI_CLIEN    as "Meg env.", 
TOT_MEG_RECU_CLIEN     as "Meg reçu"	, 
TOT_ROUND_TRIP_CLIEN   as "R-T",  
TOT_MEG_ENVOI_DB_LINK  as "Meg env. DBL" , 
TOT_MEG_RECU_DB_LINK   as "Meg reçu DBL" , 
TOT_ROUND_TRIP_DB_LINK as "R-T DBL" ,
AVG_MEG_ENVOI_CLIEN     as "Moy. Meg env.", 
AVG_MEG_RECU_CLIEN      as "Moy. Meg reçu"	, 
AVG_ROUND_TRIP_CLIEN    as "Moy. R-T",  
AVG_MEG_ENVOI_DB_LINK   as "Moy. Meg env. DBL" ,
AVG_MEG_RECU_DB_LINK    as "Moy. Meg reçu DBL" , 
AVG_ROUND_TRIP_DB_LINK  as "Moy. R-T DBL"
FROM  DRI_AUDIT.DRI_AUDIT_CONNE_DDBD_STIBD_VUE V
WHERE  CODE_UTILI_BD LIKE '&&1%'
order by CODE_UTILI_BD, ACS_DATE_LOGON;  
  

spool off
set markup HTML OFF HEAD "<style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#f7f7e7; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;} h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style><title>SQL*Plus Report</title>" BODY "" TABLE "border='1' width='95%' align='center' summary='Script output'" SPOOL OFF ENTMAP ON PRE OFF


set feedback on
set echo on