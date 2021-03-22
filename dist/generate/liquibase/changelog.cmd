@echo off

FOR /F "tokens=1,2 delims==" %%G IN (properties/version.properties) DO (set %%G=%%H)
echo %major%.%minor%

CALL liquibase --defaultsFile="properties/local/liquibase.properties" --changeLogFile="changelog/db/changelog-%major%.%minor%.mariadb.sql" generateChangeLog

pause
