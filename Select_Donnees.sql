-- ajustement des données

insert into DRI_AUDIT.DRI_AUDIT_CONNE_REGRO_2023
select *
from DRI_AUDIT_CONNE_REGRO 
where TRUNC("ACR_DATE_LOGON") < to_date('01-01-2024','dd-mm-yyyy')
and ;
151 682 025 rows created.

delete DRI_AUDIT_CONNE_REGRO 
where TRUNC("ACR_DATE_LOGON") < to_date('01-02-2023','dd-mm-yyyy');
commit;


select count(*) from  DRI_AUDIT_CONNE_REGRO;
 
select count(*) from  DRI_AUDIT_CONNE_REGRO 
where TRUNC("ACR_DATE_LOGON") > to_date('31-12-2023','dd-mm-yyyy');

select count(*) from  DRI_AUDIT_CONNE_REGRO 
where TRUNC("ACR_DATE_LOGON") < to_date('01-01-2024','dd-mm-yyyy');

-------  TEST 1 
------- https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/statistics-descriptions-2.html 
-------  TEST 3
TRUNCATE TABLE  DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD;
INSERT INTO DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD
SELECT   ACR_NO_IDENT
        ,ACR_NO_UNIQU_SESSI
		,ACR_CODE_UTILI_BD  
        ,ACR_NOM_BASE 
        ,ACR_NOM_SERVI		
        ,ACR_DATE_LOGON	
        ,ACR_NOM_PROGR                 
        ,ACR_NOM_MODUL                 
        ,ACR_NBR_LOGIC_READS_SESSI     
        ,ACR_NBR_CONSI_GETS            
        ,ACR_NBR_PHYSI_READS           
        ,ACR_NBR_PHYSI_WRITE           
        ,ACR_NBR_EXECU_COUNT           
        ,ACR_NBR_CONSI_READ_GETS       
        ,ACR_NBR_BYTE_ENVOI_CLIEN      
        ,ACR_NBR_BYTE_RECU_CLIEN       
        ,ACR_NBR_ROUND_TRIP_CLIEN      
        ,ACR_NBR_LOGIC_READ_BYTE_CACHE 
        ,ACR_NBR_PHYSI_READ_TOTAL_BYTE 
        ,ACR_NBR_BYTE_ENVOI_DB_LINK    
        ,ACR_NBR_BYTE_RECU_DB_LINK     
        ,ACR_NBR_ROUND_TRIP_DB_LINK    
        ,ACR_NBR_UNDO_CHANG_VECTO_SIZE
FROM 	DRI_AUDIT_CONNE_REGRO
WHERE  where TRUNC("ACR_DATE_LOGON") >  to_date('31-12-2023','dd-mm-yyyy')
AND  ACR_CODE_UTILI_BD NOT IN ('SYSMAN','SYS','RDBMS','MGMT_VIEW','SYSRAC','OPS$OCS$B1','SYSMAN_MDS')
AND  ACR_NOM_BASE ='P051.MRN'
AND  ACR_DATE_LOGOF IS NOT NULL	
AND ACR_NBR_BYTE_RECU_CLIEN  IS NOT NULL;
COMMIT;

/*
ajouter le nombre de transaction et la moyene et maximum/trasac.
usagers nommée.
epel mtl.

commece.
*/


Table truncated.
105 133 575 rows created.
Commit complete.


CREATE VIEW DRI_AUDIT.DRI_AUDIT_CONNE_STIBD_VUE AS 
SELECT   SUBSTR(ACS_CODE_UTILI_BD,0,3) CODE_UTILI_BD   
        ,ROUND(SUM(ACS_NBR_BYTE_ENVOI_CLIEN)/1024/1024  ,2)  NBR_MEG_ENVOI_CLIEN   
        ,ROUND(SUM(ACS_NBR_BYTE_RECU_CLIEN )/1024/1024  ,2)  NBR_MEG_RECU_CLIEN   
        ,ROUND(SUM(ACS_NBR_ROUND_TRIP_CLIEN)     		,2)  NBR_ROUND_TRIP_CLIEN
		,ROUND(SUM(ACS_NBR_BYTE_ENVOI_DB_LINK)/1024/1024,2)  NBR_MEG_ENVOI_DB_LINK
		,ROUND(SUM(ACS_NBR_BYTE_RECU_DB_LINK)/1024/1024 ,2)  NBR_MEG_RECU_DB_LINK
		,ROUND(SUM(ACS_NBR_ROUND_TRIP_DB_LINK)          ,2)  NBR_ROUND_TRIP_DB_LINK
FROM DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD
WHERE ACS_NOM_BASE = 'P051.MRN'
GROUP BY SUBSTR(ACS_CODE_UTILI_BD,0,3);


   
CREATE OR REPLACE VIEW DRI_AUDIT.DRI_AUDIT_CONNE_BD_STIBD_VUE AS 
SELECT    ACS_CODE_UTILI_BD  CODE_UTILI_BD
         ,ACS_NOM_BASE    
        ,ROUND(SUM(ACS_NBR_BYTE_ENVOI_CLIEN)/1024/1024  ,2)  NBR_MEG_ENVOI_CLIEN   
        ,ROUND(SUM(ACS_NBR_BYTE_RECU_CLIEN )/1024/1024  ,2)  NBR_MEG_RECU_CLIEN   
        ,ROUND(SUM(ACS_NBR_ROUND_TRIP_CLIEN)     		,2)  NBR_ROUND_TRIP_CLIEN
		,ROUND(SUM(ACS_NBR_BYTE_ENVOI_DB_LINK)/1024/1024,2)  NBR_MEG_ENVOI_DB_LINK
		,ROUND(SUM(ACS_NBR_BYTE_RECU_DB_LINK)/1024/1024 ,2)  NBR_MEG_RECU_DB_LINK
		,ROUND(SUM(ACS_NBR_ROUND_TRIP_DB_LINK)          ,2)  NBR_ROUND_TRIP_DB_LINK
FROM DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD
GROUP BY  ACS_CODE_UTILI_BD ,ACS_NOM_BASE;

CREATE OR REPLACE VIEW DRI_AUDIT.DRI_AUDIT_CONNE_MMBD_STIBD_VUE AS 
SELECT    ACS_CODE_UTILI_BD  CODE_UTILI_BD
         ,ACS_NOM_BASE  
		 ,TRUNC(ACS_DATE_LOGON,'MM' ) ACS_DATE_LOGON
        ,ROUND(SUM(ACS_NBR_BYTE_ENVOI_CLIEN)/1024/1024  ,2)  NBR_MEG_ENVOI_CLIEN   
        ,ROUND(SUM(ACS_NBR_BYTE_RECU_CLIEN )/1024/1024  ,2)  NBR_MEG_RECU_CLIEN   
        ,ROUND(SUM(ACS_NBR_ROUND_TRIP_CLIEN)     		,2)  NBR_ROUND_TRIP_CLIEN
		,ROUND(SUM(ACS_NBR_BYTE_ENVOI_DB_LINK)/1024/1024,2)  NBR_MEG_ENVOI_DB_LINK
		,ROUND(SUM(ACS_NBR_BYTE_RECU_DB_LINK)/1024/1024 ,2)  NBR_MEG_RECU_DB_LINK
		,ROUND(SUM(ACS_NBR_ROUND_TRIP_DB_LINK)          ,2)  NBR_ROUND_TRIP_DB_LINK
FROM DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD
GROUP BY  ACS_CODE_UTILI_BD ,ACS_NOM_BASE,TRUNC(ACS_DATE_LOGON,'MM' );