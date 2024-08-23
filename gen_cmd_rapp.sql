spool 'C:\Users\levse4\OneDrive - BuroVirtuel\Travail\GIT\Scripts_travail\GO_RAPP_HTML.SQL'

select distinct
'@''C:\Users\levse4\OneDrive - BuroVirtuel\Travail\GIT\Scripts_travail\RAPP_HTML.SQL ''' || SUBSTR(ACS_CODE_UTILI_BD,0,3)
from DRI_AUDIT.DRI_AUDIT_CONNE_STATS_IBD
WHERE  SUBSTR(ACS_CODE_UTILI_BD,0,3) in 
(select distinct SCHEMA_BD
from ccti.LISTE_SCHEMA_ORACLE)
order by  1;
spool off;