CONN LEVSEDBA@ADMIN_P051/f0c0ns
SET ECHO OFF
SET VERIFY   OFF
SET PAGESIZE 100
SET LONG 90000

ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '. ';
col "Base de  Données" 		format a20
-- col "Compte BD" 			format a15
-- col "Meg envoyé au client"  format 999 999 999.99 
-- col "Meg reçu du client"	format 999 999 999.99  
-- col "Allé-retours à la BD"  format 999 999 999.99  
-- col "Meg envoyé au client via DBLink" format 999 999 999.99  
-- col "Meg reçu du client via DBLink"   format 999 999 999.99 
-- col "Allé-retours à la BD via DBLink" format 999 999 999.99  

set numformat "9,999,999,999.99"
alter session set nls_date_format = 'YYYY-MM-DD';


set TERMOUT off;
set feedback off;
SET UNDERLINE =



break on "Base de  Données" SKIP PAGE 
COMPUTE  SUM LABEL TOTAL OF "Meg envoyé au client" on "Base de  Données"
COMPUTE  SUM LABEL TOTAL OF "Meg reçu du client" on "Base de  Données"
COMPUTE  SUM LABEL TOTAL OF "Allé-retours à la BD" on "Base de  Données"
COMPUTE  SUM LABEL TOTAL OF "Meg envoyé au client via DBLink"  on "Base de  Données"
COMPUTE  SUM LABEL TOTAL OF "Meg reçu du client via DBLink" on "Base de  Données"
COMPUTE  SUM LABEL TOTAL OF "Allé-retours à la BD via DBLink"  on "Base de  Données";

spool 'C:\Users\levse4\OneDrive - BuroVirtuel\Travail\GIT\Scripts_travail\Rapports_html\RAPP_HTML_&&1..HTML'

prompt <table border='1' width='95%' align='center' bgcolor="ffffcc" summary='Script output'>
prompt <tr> <th scope="col"> Statistiques pour &&1 pour 2024</th>  </tr>
prompt </table>

set markup HTML on HEAD "<style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;}  p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black;  background:#f7f7e7 ;     padding:0px 0px 0px 0px; margin:0px 0px 0px 0px;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White;  border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;}h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style><title>Rapport des essais de performances </title>"  BODY "" TABLE "border='1' width='95%' align='center' summary='Script output'"  SPOOL ON ENTMAP OFF  PRE OFF 

SELECT 
V.ACS_NOM_BASE  		   as "Base de  Données", 
CODE_UTILI_BD  		   as "Compte BD",
NBR_MEG_ENVOI_CLIEN    as "Meg envoyé au client", 
NBR_MEG_RECU_CLIEN     as "Meg reçu du client"	, 
NBR_ROUND_TRIP_CLIEN   as "Allé-retours à la BD",  
NBR_MEG_ENVOI_DB_LINK  as "Meg envoyé au client via DBLink" , 
NBR_MEG_RECU_DB_LINK   as "Meg reçu du client via DBLink" , 
NBR_ROUND_TRIP_DB_LINK as "Allé-retours à la BD via DBLink"  
FROM  DRI_AUDIT.DRI_AUDIT_CONNE_BD_STIBD_VUE V, DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD_TRI T
WHERE  CODE_UTILI_BD LIKE '&&1%'
and V.ACS_NOM_BASE = T.ACS_NOM_BASE
order by T.ORD_TRI || V.ACS_NOM_BASE,CODE_UTILI_BD;  


CLEAR BREAKS
CLEAR COMPUTES

prompt <table border='1' width='95%' align='center' bgcolor="ffffcc" summary='Script output'>
prompt <tr> <th scope="col"> Statistiques pour &&1 par mois </th>  </tr>
prompt </table>

break on "Base de  Données" SKIP PAGE on "Mois"
COMPUTE SUM LABEL TOTAL  OF "Meg envoyé au client" on "Base de  Données" 
COMPUTE SUM LABEL TOTAL  OF "Meg reçu du client" on "Base de  Données" 
COMPUTE SUM LABEL TOTAL  OF "Allé-retours à la BD" on "Base de  Données"  
COMPUTE SUM LABEL TOTAL  OF "Meg envoyé au client via DBLink"  on "Base de  Données" 
COMPUTE SUM LABEL TOTAL  OF "Meg reçu du client via DBLink" on "Base de  Données"
COMPUTE SUM LABEL TOTAL  OF "Allé-retours à la BD via DBLink"  on "Base de  Données" 
COMPUTE SUM LABEL TOTAL  OF "Meg envoyé au client" on "Mois"
COMPUTE SUM LABEL TOTAL  OF "Meg reçu du client" on "Mois" 
COMPUTE SUM LABEL TOTAL  OF "Allé-retours à la BD" on "Mois" 
COMPUTE SUM LABEL TOTAL  OF "Meg envoyé au client via DBLink"  on "Mois"
COMPUTE SUM LABEL TOTAL  OF "Meg reçu du client via DBLink" on "Mois"
COMPUTE SUM LABEL TOTAL  OF "Allé-retours à la BD via DBLink"  on "Mois";


SELECT  
v.ACS_NOM_BASE  as "Base de  Données", 
ACS_DATE_LOGON as "Mois",
CODE_UTILI_BD  as "Compte BD",
NBR_MEG_ENVOI_CLIEN    as "Meg envoyé au client", 
NBR_MEG_RECU_CLIEN     as "Meg reçu du client"	, 
NBR_ROUND_TRIP_CLIEN   as "Allé-retours à la BD",  
NBR_MEG_ENVOI_DB_LINK  as "Meg envoyé au client via DBLink" , 
NBR_MEG_RECU_DB_LINK   as "Meg reçu du client via DBLink" , 
NBR_ROUND_TRIP_DB_LINK as "Allé-retours à la BD via DBLink"  
FROM  DRI_AUDIT.DRI_AUDIT_CONNE_MMBD_STIBD_VUE V, DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD_TRI T
WHERE  CODE_UTILI_BD LIKE '&&1%'
and V.ACS_NOM_BASE = T.ACS_NOM_BASE
order by T.ORD_TRI || V.ACS_NOM_BASE,ACS_DATE_LOGON,CODE_UTILI_BD;  
  

spool off
set markup HTML OFF HEAD "<style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#f7f7e7; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;} h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style><title>SQL*Plus Report</title>" BODY "" TABLE "border='1' width='95%' align='center' summary='Script output'" SPOOL OFF ENTMAP ON PRE OFF


set feedback on
set echo on