REM ==============================================================================================
REM ==============================================================================================
REM ===������ ������������ ������������ � ����� �������� ��� ���������� ������� ����� RDP-�����������
REM ==============================================================================================
REM ==============================================================================================



REM ===���� 1. ����������=========================================================================

REM ==============================================================================================
REM ===��������� ������ ������������� ��������� ����������========================================
REM ==============================================================================================
setlocal enabledelayedexpansion

REM ==============================================================================================
REM ===��������� ��������� �� �������=============================================================
REM ==============================================================================================
chcp 1251
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=101& GOTO RESULT_ERROR

REM ==============================================================================================
REM ===���� ���������� ������������===============================================================
REM ==============================================================================================
SET DISTR_NAME=NorthernRay
SET PROJECT_NAME=Wash
SET WORKFLOW_FORMS_X86=false
SET SOURCE_PATH=D:\WorkflowTechnology\Clients\NorthernRay
SET CLOUD_REPOSITORY_PATH=D:\YandexDisk\����������\�������� ���

REM ==============================================================================================
REM ===���� ���������� �����======================================================================
REM ==============================================================================================
SET ARCHIVATOR_FILE_PATH=\\ws01\Share\Soft\7-Zip\7z.exe
SET UPDATES_FOLDER_PATH=D:\Updates
SET CUSTOM_WORKFLOW_FORMS_DLL_LIST_FILENAME=wf_dll.txt
SET CUSTOM_WORKFLOW_ENGINE_DLL_LIST_FILENAME=we_dll.txt



REM ===���� 2. ��������� ���������� ������������==================================================

REM ==============================================================================================
REM ===����� ���������� ������������ � �����������================================================
REM ==============================================================================================
FOR /f %%i IN ('dir "%CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_2*.*" /O:n /B') DO SET LAST_CLOUD_DISTR=%%i
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=201& GOTO RESULT_ERROR
IF "%LAST_CLOUD_DISTR%"=="" SET ERROR_CODE=202& GOTO RESULT_ERROR

REM ==============================================================================================
REM ===�������� ��������� ����� � �������������===================================================
REM ==============================================================================================
rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%" /S /Q
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=203& GOTO RESULT_ERROR

REM ==============================================================================================
REM ===���������� ������������ �� ������ ����������� �� ��������� �����===========================
REM ==============================================================================================
%ARCHIVATOR_FILE_PATH% x "%CLOUD_REPOSITORY_PATH%\%LAST_CLOUD_DISTR%" -o"%UPDATES_FOLDER_PATH%\%DISTR_NAME%" -y
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=204& GOTO RESULT_ERROR



REM ===���� 3. ��������� ���������� ���������� �� ������������====================================

REM ==============================================================================================
REM ===��������� ���������� ���������� �� ������������============================================
REM ==============================================================================================
echo.&echo.&echo Updates parameters:&echo db - only "Database" folder&echo fx - only "Forms" folder&echo wx - only "Workflow" folder&echo wf - only "WorkflowForms" folder&echo we - only "WorkflowEngine" folder&echo desc - only "Description" folder&echo all - all folders&echo xml - only "Forms" and "Workflow" folders&echo dx - only "Database", "Forms" and "Workflow" folders&echo df - only "Database", "Forms", "Workflow" and "WorkflowForms" folders
SET /P UPDATE_PARAMETERS=Enter update parameters (could be several parameters):



REM ===���� 4. ���������� ����� "DATABASE"========================================================

REM ==============================================================================================
REM ===���������� ����� "DATABASE" �� ��������� ����� ������������================================
REM ==============================================================================================
SET expression=false
IF NOT "%UPDATE_PARAMETERS:db=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Database" /S /Q
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=401& GOTO RESULT_ERROR
	xcopy "%SOURCE_PATH%\Development\database" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Database" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=402& GOTO RESULT_ERROR
)



REM ===���� 5. ���������� ����� "FORMS"===========================================================

REM ==============================================================================================
REM ===���������� ����� "FORMS" �� ��������� ����� ������������===================================
REM ==============================================================================================
SET expression=false
IF NOT "%UPDATE_PARAMETERS:fx=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:xml=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Forms" /S /Q	
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=501& GOTO RESULT_ERROR
	xcopy "%SOURCE_PATH%\Projects\1. %PROJECT_NAME%\Forms" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Forms" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=502& GOTO RESULT_ERROR
	del "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Forms\.project"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=503& GOTO RESULT_ERROR
)



REM ===���� 6. ���������� ����� "WORKFLOW"========================================================

REM ==============================================================================================
REM ===���������� ����� "WORKFLOW" �� ��������� ����� ������������================================
REM ==============================================================================================
SET expression=false
IF NOT "%UPDATE_PARAMETERS:wx=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:xml=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Workflow" /S /Q	
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=601& GOTO RESULT_ERROR
	xcopy "%SOURCE_PATH%\Projects\1. %PROJECT_NAME%\Workflow" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Workflow" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=602& GOTO RESULT_ERROR
)



REM ===���� 7. ���������� ����� "WORKFLOW FORMS"==================================================

REM ==============================================================================================
REM ===���������� ����� "WORKFLOW FORMS" �� ��������� ����� ������������==========================
REM ==============================================================================================
IF %WORKFLOW_FORMS_X86%==true (SET "WORKFLOW_FORMS_SUFFIX= (x86)") ELSE (SET "WORKFLOW_FORMS_SUFFIX=")
SET expression=false
IF NOT "%UPDATE_PARAMETERS:wf=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms" /S /Q
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=701& GOTO RESULT_ERROR
	xcopy "\\ws01\Share\WT\WorkflowForms.v1\bin%WORKFLOW_FORMS_SUFFIX%" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms\bin%WORKFLOW_FORMS_SUFFIX%" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=702& GOTO RESULT_ERROR
	xcopy "\\ws01\Share\WT\WorkflowForms.v1\config" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms\config" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=703& GOTO RESULT_ERROR
	copy "\\ws01\Share\WT\WorkflowForms.v1\^!nfo%WORKFLOW_FORMS_SUFFIX%.txt" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms\^!nfo%WORKFLOW_FORMS_SUFFIX%.txt" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=704& GOTO RESULT_ERROR
	copy "\\ws01\Share\WT\WorkflowForms.v1\WorkflowForms%WORKFLOW_FORMS_SUFFIX%.msi" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms\WorkflowForms%WORKFLOW_FORMS_SUFFIX%.msi" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=705& GOTO RESULT_ERROR
	IF EXIST "%SOURCE_PATH%\Development\deploy\WorkflowForms.Extends.xml" (
    	copy "%SOURCE_PATH%\Development\deploy\WorkflowForms.Extends.xml" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms" /Y
	    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=706& GOTO RESULT_ERROR
	)
	
	REM ===����������� ��������� ��������� ��� WORKFLOW FORMS=====================================
    FOR /f "delims=" %%i IN (%SOURCE_PATH%\Development\assembly\%CUSTOM_WORKFLOW_FORMS_DLL_LIST_FILENAME%) DO (
        copy "%%i" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms" /Y
	    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=707& GOTO RESULT_ERROR
	    copy "%%i" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms\bin%WORKFLOW_FORMS_SUFFIX%" /Y
	    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=708& GOTO RESULT_ERROR
    )
)



REM ===���� 8. ���������� ����� "WORKFLOW ENGINE"=================================================

REM ==============================================================================================
REM ===���������� ����� "WORKFLOW ENGINE" �� ��������� ����� ������������=========================
REM ==============================================================================================
SET expression=false
IF NOT "%UPDATE_PARAMETERS:we=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine" /S /Q
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=801& GOTO RESULT_ERROR
	xcopy "\\ws01\Share\WT\WorkflowEngine.v1\bin" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine\bin" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=802& GOTO RESULT_ERROR
	xcopy "\\ws01\Share\WT\WorkflowEngine.v1\config" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine\config" /E /I /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=803& GOTO RESULT_ERROR
	copy "\\ws01\Share\WT\WorkflowEngine.v1\^!nfo.txt" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine\^!nfo.txt" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=804& GOTO RESULT_ERROR
	copy "\\ws01\Share\WT\WorkflowEngine.v1\WorkflowEngine.msi" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine\WorkflowEngine.msi" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=805& GOTO RESULT_ERROR
	
	REM ===����������� ��������� ��������� ��� WORKFLOW ENGINE====================================
	FOR /f "delims=" %%i IN (%SOURCE_PATH%\Development\assembly\%CUSTOM_WORKFLOW_ENGINE_DLL_LIST_FILENAME%) DO (
        copy "%%i" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine" /Y
	    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=806& GOTO RESULT_ERROR
	    copy "%%i" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine\bin" /Y
	    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=807& GOTO RESULT_ERROR
    )
)



REM ===���� 9. ���������� ����� "��������"========================================================

REM ==============================================================================================
REM ===���������� ����� "��������" �� ��������� ����� ������������================================
REM ==============================================================================================
SET expression=false
IF NOT "%UPDATE_PARAMETERS:desc=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF NOT "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" SET expression=true
IF %expression%==true (
	rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������" /S /Q
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=901& GOTO RESULT_ERROR
	mkdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������"
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=902& GOTO RESULT_ERROR
	copy "%SOURCE_PATH%\Development\deploy\backup_database_workflow_technology.bat" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=903& GOTO RESULT_ERROR
	copy "S:\WT\����������\���������� �� �������� WT-��������� (��������� v1).pdf" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=904& GOTO RESULT_ERROR
	copy "S:\WT\����������\���������� �� ��������� WT-��������� (��������� v1).pdf" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������" /Y
	IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=905& GOTO RESULT_ERROR
)



REM ===���� 10. ��������� ������ ������ ������ ������������=======================================

REM ==============================================================================================
REM ===������������� ��������� ����� ��� ��������� ������ ������ ������������=====================
REM ==============================================================================================
del "%UPDATES_FOLDER_PATH%\%DISTR_NAME%.7z"
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1001& GOTO RESULT_ERROR
%ARCHIVATOR_FILE_PATH% a "%UPDATES_FOLDER_PATH%\%DISTR_NAME%.7z" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\*" -y -mx9
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1002& GOTO RESULT_ERROR

REM ==============================================================================================
REM ==����������� ������ ������ ������������ � �����������========================================
REM ==============================================================================================
copy "%UPDATES_FOLDER_PATH%\%DISTR_NAME%.7z" "%CLOUD_REPOSITORY_PATH%" /Y
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1003& GOTO RESULT_ERROR



REM ===���� 11. ��������� ������ ������ ������������==============================================

REM ==============================================================================================
REM ===�������� �������������� ����������� �� ��������� ����� ������������========================
REM ==============================================================================================
rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Database\create" /S /Q
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1101& GOTO RESULT_ERROR
IF "%UPDATE_PARAMETERS:db=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Database" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1102& GOTO RESULT_ERROR
)
IF "%UPDATE_PARAMETERS:fx=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:xml=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Forms" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1103& GOTO RESULT_ERROR
)
IF "%UPDATE_PARAMETERS:wx=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:xml=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:dx=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\Workflow" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1104& GOTO RESULT_ERROR
)
IF "%UPDATE_PARAMETERS:wf=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:df=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowForms" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1105& GOTO RESULT_ERROR
)
IF "%UPDATE_PARAMETERS:we=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\WorkflowEngine" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1106& GOTO RESULT_ERROR
)
IF "%UPDATE_PARAMETERS:desc=%"=="%UPDATE_PARAMETERS%" IF "%UPDATE_PARAMETERS:all=%"=="%UPDATE_PARAMETERS%" (
    rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\��������" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1107& GOTO RESULT_ERROR
)

REM ==============================================================================================
REM ===������������� ��������� ����� ��� ��������� ������ ������������============================
REM ==============================================================================================
del "%UPDATES_FOLDER_PATH%\%DISTR_NAME%_update.7z"
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1108& GOTO RESULT_ERROR
%ARCHIVATOR_FILE_PATH% a "%UPDATES_FOLDER_PATH%\%DISTR_NAME%_update.7z" "%UPDATES_FOLDER_PATH%\%DISTR_NAME%\*" -y -mx9
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1109& GOTO RESULT_ERROR

REM ==============================================================================================
REM ==����������� ������ ������������ � �����������===============================================
REM ==============================================================================================
copy "%UPDATES_FOLDER_PATH%\%DISTR_NAME%_update.7z" "%CLOUD_REPOSITORY_PATH%" /Y
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1110& GOTO RESULT_ERROR

REM ==============================================================================================
REM ===�������� ��������� ����� � �������������===================================================
REM ==============================================================================================
rmdir "%UPDATES_FOLDER_PATH%\%DISTR_NAME%" /S /Q
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1111& GOTO RESULT_ERROR





REM ==============================================================================================
REM ===����� ���������� � ��������� ������������� ���������� ������ �������=======================
REM ==============================================================================================
echo.&echo.&echo.&echo Result is OK&echo.&echo.
pause
exit





REM ==============================================================================================
REM ===����� ���������� �� ������ � ������ �������================================================
REM ==============================================================================================
:RESULT_ERROR
echo.&echo.&echo.&echo ERROR code is %ERROR_CODE%. See batch script for details.&echo.&echo.
pause
exit