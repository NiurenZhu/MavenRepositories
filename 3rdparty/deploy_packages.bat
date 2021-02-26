@echo off
setlocal EnableDelayedExpansion
echo ***************************************************************************
echo      deploy_packages.bat
echo                     by niuren.zhu
echo                           2017.09.06
echo  ˵����
echo     1. �ϴ�jar����maven�ֿ⡣
echo     2. ���PATH������%%MAVEN_HOME%%\bin�������JAVA_HOME�����Ƿ���ȷ��
echo     3. ��setting.xml��^<servers^>�ڵ�����ӣ������û�����������Ҫ�����Ա���룩
echo             ^<server^>
echo               ^<id^>ibas-maven^<^/id^>
echo               ^<username^>�û���^<^/username^>
echo               ^<password^>����^<^/password^>
echo             ^<^/server^>
echo ****************************************************************************
REM ���ò�������
SET WORK_FOLDER=%~dp0
REM �ֿ����ַ
SET ROOT_URL=http://maven.colorcoding.org/repository/

echo --��ʼ����
CALL :DEPLOY_PACKAGE com.sap.hana ngdbc 1.0 %WORK_FOLDER%\ngdbc-1.0.jar maven-3rdparty
CALL :DEPLOY_PACKAGE com.sap.hana ngdbc 2.3 %WORK_FOLDER%\ngdbc-2.3.jar maven-3rdparty
CALL :DEPLOY_PACKAGE com.sap.hana ngdbc 2.4 %WORK_FOLDER%\ngdbc-2.4.jar maven-3rdparty
CALL :DEPLOY_PACKAGE com.microsoft.sqlserver sqljdbc 4.2 %WORK_FOLDER%\sqljdbc-4.2.jar maven-3rdparty


echo --�������

goto :EOF
REM ����Ϊ����
:DEPLOY_PACKAGE
set GROUP_ID=%1
set ARTIFACT_ID=%2
set VERSION=%3
set FILE=%4
set REPOSITORY=%5
set PACKAGING=jar
set REPOSITORY_ID=ibas-maven
set REPOSITORY_URL=%ROOT_URL%%REPOSITORY%

call mvn deploy:deploy-file ^
    -DgroupId=%GROUP_ID% ^
    -DartifactId=%ARTIFACT_ID% ^
    -Dversion=%VERSION% ^
    -Dpackaging=%PACKAGING% ^
    -Dfile="%FILE%" ^
    -Durl=%REPOSITORY_URL% ^
    -DrepositoryId=%REPOSITORY_ID%
goto :EOF