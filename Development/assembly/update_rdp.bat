REM ==============================================================================================
REM ==============================================================================================
REM ===������ ������������� ������ ������������ �� ���������� ��������� ������� � ����� �������� ����� RDP-�����������
REM ==============================================================================================
REM ==============================================================================================



REM ===���� 1. ����������=========================================================================

REM ==============================================================================================
REM ===��������� ������ ������������� ��������� ����������========================================
REM ==============================================================================================
setlocal enabledelayedexpansion

REM ==============================================================================================
REM ===�������� ������� ��������� ����============================================================
REM ==============================================================================================
net session >NUL 2>&1
IF NOT !ERRORLEVEL! == 0 (
    echo.&echo.&echo.&echo Update script should start with administrative permissions&echo.&echo.&echo.
    pause
    exit
)

REM ==============================================================================================
REM ===��������� ��������� �� �������=============================================================
REM ==============================================================================================
chcp 1251
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=101& GOTO RESULT_ERROR

REM ==============================================================================================
REM ===���� ���������� ������������===============================================================
REM ==============================================================================================
SET DISTR_NAME=NorthernRay
SET DISTR_NAME_LOWER_CASE=northernray
SET PROJECT_NAME=Wash
SET WORKFLOW_FORMS_X86=false

REM ==============================================================================================
REM ===���� ���������� ����� ������� �������======================================================
REM ==============================================================================================
SET CLIENT_DISTR_PATH=D:\WorkflowSystems
SET CLIENT_ARCHIVATOR_FILE_PATH=D:\WorkflowSystems\Soft\7z.exe
SET CLIENT_POSTGRES_BIN_PATH=D:\PostgreSQL\8.4\bin
SET CLIENT_DATABASE_SERVER=localhost
SET CLIENT_DATABASE_PORT=5432
SET CLIENT_DATABASE_PASSWORD=northernray
SET CLIENT_DATABASE_NAME=workflow_technology
SET CLIENT_WORKFLOW_FORMS_PATH=C:\Program Files (x86)\Workflow Systems\Workflow Forms
SET CLIENT_WORKFLOW_ENGINE_BIN_PATH=C:\inetpub\wwwroot\WorkflowEngine\bin
SET CLIENT_PROJECT_FORMS_PATH=C:\inetpub\wwwroot\WorkflowEngine\Projects\Wash
SET CLIENT_PROJECT_WORKFLOW_PATH=C:\inetpub\wwwroot\WorkflowEngine\Projects\Wash

REM ==============================================================================================
REM ===���� ���������� ����� ���������� ������������==============================================
REM ==============================================================================================
SET DEVELOPER_DISTR_PATH=\\tsclient\D\WorkflowTechnology\Clients\NorthernRay
SET DEVELOPER_CLOUD_REPOSITORY_PATH=\\tsclient\D\YandexDisk\����������\�������� ���
SET DEVELOPER_CLOUD_REPOSITORY_FILENAME=NorthernRay_update.7z

REM ==============================================================================================
REM ===���� ��������� ����������==================================================================
REM ==============================================================================================
SET DATETIME_STAMP=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
SET DATE_STAMP=%date:~6,4%%date:~3,2%%date:~0,2%



REM ===���� 2. ��������� ������ ������������======================================================

REM ==============================================================================================
REM ===��������� ������ ������������ � ���������� ������������====================================
REM ==============================================================================================
rmdir "%CLIENT_DISTR_PATH%\_update" /S /Q
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=201& GOTO RESULT_ERROR
mkdir "%CLIENT_DISTR_PATH%\_update"
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=202& GOTO RESULT_ERROR
IF NOT EXIST "%CLIENT_DISTR_PATH%\%DEVELOPER_CLOUD_REPOSITORY_FILENAME%" (
    copy "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DEVELOPER_CLOUD_REPOSITORY_FILENAME%" "%CLIENT_DISTR_PATH%" /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=203& GOTO RESULT_ERROR
)

REM ==============================================================================================
REM ===���������� ������ ������������ �� ������ �� ��������� �����================================
REM ==============================================================================================
"%CLIENT_ARCHIVATOR_FILE_PATH%" x "%CLIENT_DISTR_PATH%\%DEVELOPER_CLOUD_REPOSITORY_FILENAME%" -o"%CLIENT_DISTR_PATH%\_update" -y
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=204& GOTO RESULT_ERROR



REM ===���� 3. ���������� ���� ������=============================================================

REM ==============================================================================================
REM ===������ � ������ "DATABASE" �� ������ ������������==========================================
REM ==============================================================================================
IF EXIST "%CLIENT_DISTR_PATH%\_update\Database\update.txt" (
    REM ===�������� ��������� ����� ���� ������ �� ����������=====================================
    SET PGPASSWORD=%CLIENT_DATABASE_PASSWORD%
    mkdir "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=301& GOTO RESULT_ERROR
    "%CLIENT_POSTGRES_BIN_PATH%\pg_dump.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres --format custom --column-inserts --verbose --file "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup" %CLIENT_DATABASE_NAME% > "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.txt" 2>&1
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=302& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=303& GOTO RESULT_ERROR
    "%CLIENT_ARCHIVATOR_FILE_PATH%" a "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.7z" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup" -y -mx9 -pworkflowsystems_wfsys -mhe
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=304& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=305& GOTO RESULT_ERROR

    REM ===���������� ���� ������=================================================================
    "%CLIENT_POSTGRES_BIN_PATH%\psql.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres -f "%CLIENT_DISTR_PATH%\_update\Database\update.txt" -v ON_ERROR_STOP=1 --single-transaction %CLIENT_DATABASE_NAME%
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=306& GOTO RESULT_ERROR

    REM ===�������� ��������� ����� ���� ������ ����� ����������==================================
    "%CLIENT_POSTGRES_BIN_PATH%\pg_dump.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres --format custom --column-inserts --verbose --file "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup" %CLIENT_DATABASE_NAME% > "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.txt" 2>&1
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=307& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=308& GOTO RESULT_ERROR
    "%CLIENT_ARCHIVATOR_FILE_PATH%" a "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup" -y -mx9 -pworkflowsystems_wfsys -mhe
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=309& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=310& GOTO RESULT_ERROR

    REM ===���������� ��������� ����� ������������================================================
    IF EXIST "%CLIENT_DISTR_PATH%\Database\create" xcopy "%CLIENT_DISTR_PATH%\Database\create" "%CLIENT_DISTR_PATH%\_update\Database\create" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=311& GOTO RESULT_ERROR
    rmdir "%CLIENT_DISTR_PATH%\Database" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=312& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\Database" "%CLIENT_DISTR_PATH%\Database" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=313& GOTO RESULT_ERROR
    rmdir "%CLIENT_DISTR_PATH%\_update\Database\create" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=314& GOTO RESULT_ERROR

    REM ===�������������� ����� � ����������� ���� ������ � ����� ������������====================
    SET DATE_STAMP_SUFFIX=empty
    IF EXIST "%DEVELOPER_DISTR_PATH%\Development\database\update%DATE_STAMP%_1.txt" (
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=315& GOTO RESULT_ERROR
        FOR /L %%i IN (1,1,100) DO IF NOT EXIST "%DEVELOPER_DISTR_PATH%\Development\database\update%DATE_STAMP%_%%i.txt" SET DATE_STAMP_SUFFIX=_%%i&GOTO DATE_STAMP_SUFFIX_IS_DETERMINED
    )
    :DATE_STAMP_SUFFIX_IS_DETERMINED
    IF "%DATE_STAMP_SUFFIX%"=="empty" IF EXIST "%DEVELOPER_DISTR_PATH%\Development\database\update%DATE_STAMP%.txt" (
        ren "%DEVELOPER_DISTR_PATH%\Development\database\update%DATE_STAMP%.txt" "update%DATE_STAMP%_1.txt"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=316& GOTO RESULT_ERROR
        ren "%DEVELOPER_DISTR_PATH%\Development\database\update.txt" "update%DATE_STAMP%_2.txt"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=317& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_UPDATE_IS_DONE
    )
    IF "%DATE_STAMP_SUFFIX%"=="empty" IF NOT EXIST "%DEVELOPER_DISTR_PATH%\Development\database\update%DATE_STAMP%.txt" (
        ren "%DEVELOPER_DISTR_PATH%\Development\database\update.txt" "update%DATE_STAMP%.txt"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=318& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_UPDATE_IS_DONE
    )
    IF NOT "%DATE_STAMP_SUFFIX%"=="empty" (
        ren "%DEVELOPER_DISTR_PATH%\Development\database\update.txt" "update%DATE_STAMP%%DATE_STAMP_SUFFIX%.txt"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=319& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_UPDATE_IS_DONE
    )
    :RENAME_DATABASE_UPDATE_IS_DONE
    echo Rename is done

    REM ===�������� ��������� ����� ���� ������ ����� ���������� �� ��������� ������������========
    IF EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%_1.7z" (
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=320& GOTO RESULT_ERROR
        FOR /L %%i IN (1,1,100) DO IF NOT EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%_%%i.7z" SET DATE_STAMP_SUFFIX=_%%i&GOTO DATE_STAMP_SUFFIX_IS_DETERMINED
    )
    :DATE_STAMP_SUFFIX_IS_DETERMINED
    IF NOT "%DATE_STAMP_SUFFIX%"=="empty" (
        copy "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z" "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%%DATE_STAMP_SUFFIX%.7z" /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=321& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_IS_DONE
    )
    IF "%DATE_STAMP_SUFFIX%"=="empty" IF NOT EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%.7z" (
        copy "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z" "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%.7z" /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=322& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_IS_DONE
    )
    IF "%DATE_STAMP_SUFFIX%"=="empty" IF EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%.7z" (
        ren "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%.7z" "%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%_1.7z"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=323& GOTO RESULT_ERROR
        copy "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z" "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME_LOWER_CASE%_original_%DATE_STAMP%_2.7z" /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=324& GOTO RESULT_ERROR
        GOTO RENAME_DATABASE_IS_DONE
    )
    :RENAME_DATABASE_IS_DONE
    echo Rename is done
)



REM ===���� 4. ���������� ����������� ����������==================================================

REM ==============================================================================================
REM ===������ � ������ "WORKFLOW FORMS" �� ������ ������������====================================
REM ==============================================================================================
IF %WORKFLOW_FORMS_X86%==true (SET "WORKFLOW_FORMS_SUFFIX= (x86)") ELSE (SET "WORKFLOW_FORMS_SUFFIX=")
IF EXIST "%CLIENT_DISTR_PATH%\_update\WorkflowForms\bin%WORKFLOW_FORMS_SUFFIX%" (
    REM ===�������������� ���������� ���������� ����������� ����������� ����������================
    FOR /F %%i IN ('tasklist /NH /FI "IMAGENAME eq WorkflowForms.exe"') DO IF "%%i" == "WorkflowForms.exe" GOTO WORKFLOW_FORMS_EXE_IS_RUNNING
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=401& GOTO RESULT_ERROR
    GOTO WORKFLOW_FORMS_EXE_IS_NOT_RUNNING
    :WORKFLOW_FORMS_EXE_IS_RUNNING
    echo.&echo.&echo.
    SET /P TERMINATE_WORKFLOW_FORMS=Application "WorkflowForms.exe" is running now. It will be terminated to update its files correctly. Please notify all users. When is done, press ENTER...
    taskkill /FI "IMAGENAME eq WorkflowForms.exe" /F
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=402& GOTO RESULT_ERROR

    REM ===�������� ��������� ����� ����������� ���������� �� ����������==========================
    :WORKFLOW_FORMS_EXE_IS_NOT_RUNNING
    xcopy "%CLIENT_WORKFLOW_FORMS_PATH%" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\WorkflowForms" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=403& GOTO RESULT_ERROR

    REM ===���������� ����������� ����������======================================================
    xcopy "%CLIENT_DISTR_PATH%\_update\WorkflowForms\bin%WORKFLOW_FORMS_SUFFIX%" "%CLIENT_WORKFLOW_FORMS_PATH%"  /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=404& GOTO RESULT_ERROR

    REM ===���������� ��������� ����� ������������================================================
    rmdir "%CLIENT_DISTR_PATH%\WorkflowForms" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=405& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\WorkflowForms" "%CLIENT_DISTR_PATH%\WorkflowForms" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=406& GOTO RESULT_ERROR
)



REM ===���� 5. ���������� ��������� ����� ����������==============================================

REM ==============================================================================================
REM ===������ � ������ "WORKFLOW ENGINE" �� ������ ������������===================================
REM ==============================================================================================
IF EXIST "%CLIENT_DISTR_PATH%\_update\WorkflowEngine\bin" (
    REM ===�������� ��������� ����� ����������� ���������� �� ����������==========================
    xcopy "%CLIENT_WORKFLOW_ENGINE_BIN_PATH%" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\WorkflowEngine" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=501& GOTO RESULT_ERROR

    REM ===���������� ���������� ��������� ����� ����������=======================================
    del "%CLIENT_WORKFLOW_ENGINE_BIN_PATH%\*.*" /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=502& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\WorkflowEngine\bin" "%CLIENT_WORKFLOW_ENGINE_BIN_PATH%" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=503& GOTO RESULT_ERROR

    REM ===���������� ��������� ����� ������������================================================
    rmdir "%CLIENT_DISTR_PATH%\WorkflowEngine" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=504& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\WorkflowEngine" "%CLIENT_DISTR_PATH%\WorkflowEngine" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=505& GOTO RESULT_ERROR
)



REM ===���� 6. ���������� XML-������==============================================================

REM ==============================================================================================
REM ===������ � ������� "FORMS" � "WORKFLOW" �� ������ ������������. ����������===================
REM ==============================================================================================
IF EXIST "%CLIENT_DISTR_PATH%\_update\Forms" (
    REM ===�������� ��������� ����� ���������� XML-������=========================================
    xcopy "%CLIENT_PROJECT_FORMS_PATH%" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Forms" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=601& GOTO RESULT_ERROR
    IF "%CLIENT_PROJECT_FORMS_PATH%" == "%CLIENT_PROJECT_WORKFLOW_PATH%" (
        del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Forms\%PROJECT_NAME%.xml"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=602& GOTO RESULT_ERROR
    )
)
IF EXIST "%CLIENT_DISTR_PATH%\_update\Workflow" (
    REM ===�������� ��������� ����� ���������� XML-�����==========================================
    mkdir "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Workflow"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=603& GOTO RESULT_ERROR
    copy "%CLIENT_PROJECT_WORKFLOW_PATH%\%PROJECT_NAME%.xml" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Workflow" /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=604& GOTO RESULT_ERROR
)
IF EXIST "%CLIENT_DISTR_PATH%\_update\Forms" (
    REM ===�������� ���������� XML-������=========================================================
    IF "%CLIENT_PROJECT_FORMS_PATH%" == "%CLIENT_PROJECT_WORKFLOW_PATH%" (
        mkdir "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Workflow"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=605& GOTO RESULT_ERROR
        copy "%CLIENT_PROJECT_WORKFLOW_PATH%\%PROJECT_NAME%.xml" "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Workflow" /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=606& GOTO RESULT_ERROR
    )
    rmdir "%CLIENT_PROJECT_FORMS_PATH%" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=607& GOTO RESULT_ERROR
    IF "%CLIENT_PROJECT_FORMS_PATH%" == "%CLIENT_PROJECT_WORKFLOW_PATH%" (
        IF NOT EXIST "%CLIENT_PROJECT_WORKFLOW_PATH%" mkdir "%CLIENT_PROJECT_WORKFLOW_PATH%"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=608& GOTO RESULT_ERROR
        copy "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Workflow\%PROJECT_NAME%.xml" "%CLIENT_PROJECT_WORKFLOW_PATH%" /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=609& GOTO RESULT_ERROR
        rmdir "%CLIENT_DISTR_PATH%\_temp" /S /Q
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=610& GOTO RESULT_ERROR
    )
)
IF EXIST "%CLIENT_DISTR_PATH%\_update\Workflow" (
    REM ===�������� ���������� XML-�����==========================================================
    IF "%CLIENT_PROJECT_FORMS_PATH%" == "%CLIENT_PROJECT_WORKFLOW_PATH%" (
        mkdir "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Forms"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=611& GOTO RESULT_ERROR
        xcopy "%CLIENT_PROJECT_FORMS_PATH%" "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Forms" /E /I /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=612& GOTO RESULT_ERROR
        del "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Forms\%PROJECT_NAME%.xml"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=613& GOTO RESULT_ERROR
    )
    rmdir "%CLIENT_PROJECT_WORKFLOW_PATH%" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=614& GOTO RESULT_ERROR
    IF "%CLIENT_PROJECT_FORMS_PATH%" == "%CLIENT_PROJECT_WORKFLOW_PATH%" (
        IF NOT EXIST "%CLIENT_PROJECT_WORKFLOW_PATH%" mkdir "%CLIENT_PROJECT_WORKFLOW_PATH%"
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=615& GOTO RESULT_ERROR
        xcopy "%CLIENT_DISTR_PATH%\_temp\%DATETIME_STAMP%\Forms" "%CLIENT_PROJECT_WORKFLOW_PATH%" /E /I /Y
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=616& GOTO RESULT_ERROR
        rmdir "%CLIENT_DISTR_PATH%\_temp" /S /Q
        IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=617& GOTO RESULT_ERROR
    )
)

REM ==============================================================================================
REM ===������ � ������� "FORMS" � "WORKFLOW" �� ������ ������������. ���������====================
REM ==============================================================================================
IF EXIST "%CLIENT_DISTR_PATH%\_update\Forms" (
    REM ===��������� ���������� XML-������========================================================
    xcopy "%CLIENT_DISTR_PATH%\_update\Forms" "%CLIENT_PROJECT_FORMS_PATH%" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=618& GOTO RESULT_ERROR

    REM ===���������� ��������� ����� ������������================================================
    rmdir "%CLIENT_DISTR_PATH%\Forms" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=619& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\Forms" "%CLIENT_DISTR_PATH%\Forms" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=620& GOTO RESULT_ERROR
)
IF EXIST "%CLIENT_DISTR_PATH%\_update\Workflow" (
    REM ===��������� ���������� XML-�����=========================================================
    IF NOT EXIST "%CLIENT_PROJECT_WORKFLOW_PATH%" mkdir "%CLIENT_PROJECT_WORKFLOW_PATH%"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=621& GOTO RESULT_ERROR
    copy "%CLIENT_DISTR_PATH%\_update\Workflow\%PROJECT_NAME%.xml" "%CLIENT_PROJECT_WORKFLOW_PATH%"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=622& GOTO RESULT_ERROR

    REM ===���������� ��������� ����� ������������================================================
    rmdir "%CLIENT_DISTR_PATH%\Workflow" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=623& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\Workflow" "%CLIENT_DISTR_PATH%\Workflow" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=624& GOTO RESULT_ERROR
)



REM ===���� 7. ���������� ��������������� ������==================================================

REM ==============================================================================================
REM ===������ � ������ "��������" �� ������ ������������==========================================
REM ==============================================================================================
IF EXIST "%CLIENT_DISTR_PATH%\_update\��������" (
    REM ===�������� ��������� ��������������� ������==============================================
    xcopy "%CLIENT_DISTR_PATH%\��������" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\��������" /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=701& GOTO RESULT_ERROR

    REM ===���������� ��������������� ������ � ��������� ������������=============================
    rmdir "%CLIENT_DISTR_PATH%\��������" /S /Q
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=702& GOTO RESULT_ERROR
    xcopy "%CLIENT_DISTR_PATH%\_update\��������" "%CLIENT_DISTR_PATH%\��������"  /E /I /Y
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=703& GOTO RESULT_ERROR
)



REM ===���� 8. ������ ���������� �� ����������====================================================

REM ==============================================================================================
REM ===������ ���������� �� ����������============================================================
REM ==============================================================================================
IF NOT EXIST "%CLIENT_DISTR_PATH%\_update\Database\update.txt" (
    REM ===�������� ��������� ����� ���� ������ �� ������ ���������� �� ����������================
    SET PGPASSWORD=%CLIENT_DATABASE_PASSWORD%
    mkdir "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=801& GOTO RESULT_ERROR
    "%CLIENT_POSTGRES_BIN_PATH%\pg_dump.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres --format custom --column-inserts --verbose --file "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup" %CLIENT_DATABASE_NAME% > "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.txt" 2>&1
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=802& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=803& GOTO RESULT_ERROR
    "%CLIENT_ARCHIVATOR_FILE_PATH%" a "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.7z" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup" -y -mx9 -pworkflowsystems_wfsys -mhe
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=804& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_before_updated.backup"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=805& GOTO RESULT_ERROR
)

REM ===������ ���������� �� ���������� � ���� ������==============================================
"%CLIENT_POSTGRES_BIN_PATH%\psql.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres -c "CREATE FUNCTION public._create_about() RETURNS void AS $BODY$ BEGIN IF (SELECT COUNT(*) = 0 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'about') THEN CREATE TABLE public.about(about_id bigserial NOT NULL, update_date timestamp without time zone NOT NULL DEFAULT now(), CONSTRAINT pk_about_id PRIMARY KEY (about_id)); END IF; INSERT INTO public.about(update_date) VALUES(DEFAULT); RETURN; END; $BODY$ LANGUAGE 'plpgsql'; SELECT public._create_about(); DROP FUNCTION public._create_about();" %CLIENT_DATABASE_NAME%
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=806& GOTO RESULT_ERROR

IF NOT EXIST "%CLIENT_DISTR_PATH%\_update\Database\update.txt" (
    REM ===�������� ��������� ����� ���� ������ ����� ������ ���������� �� ����������=============
    "%CLIENT_POSTGRES_BIN_PATH%\pg_dump.exe" --host %CLIENT_DATABASE_SERVER% --port %CLIENT_DATABASE_PORT% --username postgres --format custom --column-inserts --verbose --file "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup" %CLIENT_DATABASE_NAME% > "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.txt" 2>&1
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=807& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=808& GOTO RESULT_ERROR
    "%CLIENT_ARCHIVATOR_FILE_PATH%" a "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_original.7z" "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup" -y -mx9 -pworkflowsystems_wfsys -mhe
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=809& GOTO RESULT_ERROR
    del "%CLIENT_DISTR_PATH%\_backup\%DATETIME_STAMP%\Database\%DISTR_NAME_LOWER_CASE%_updated.backup"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=810& GOTO RESULT_ERROR
)



REM ===���� 9. ��������� ������� �� �������� ���������� �� ���������� ������������================

REM ==============================================================================================
REM ===�������������� ������������ � ����������� �� ���������� ������������=======================
REM ==============================================================================================
SET DATE_STAMP_SUFFIX=empty
IF EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_%DATE_STAMP%_1.7z" (
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=901& GOTO RESULT_ERROR
    FOR /L %%i IN (1,1,100) DO IF NOT EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_%DATE_STAMP%_%%i.7z" SET DATE_STAMP_SUFFIX=_%%i&GOTO DATE_STAMP_SUFFIX_IS_DETERMINED
)
:DATE_STAMP_SUFFIX_IS_DETERMINED
IF "%DATE_STAMP_SUFFIX%"=="empty" IF EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_%DATE_STAMP%.7z" (
    ren "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_%DATE_STAMP%.7z" "%DISTR_NAME%_%DATE_STAMP%_1.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=902& GOTO RESULT_ERROR
    ren "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%.7z" "%DISTR_NAME%_%DATE_STAMP%_2.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=903& GOTO RESULT_ERROR
    GOTO RENAME_DISTR_IS_DONE
)
IF "%DATE_STAMP_SUFFIX%"=="empty" IF NOT EXIST "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%_%DATE_STAMP%.7z" (
    ren "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%.7z" "%DISTR_NAME%_%DATE_STAMP%.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=904& GOTO RESULT_ERROR
    GOTO RENAME_DISTR_IS_DONE
)
IF NOT "%DATE_STAMP_SUFFIX%"=="empty" (
    ren "%DEVELOPER_CLOUD_REPOSITORY_PATH%\%DISTR_NAME%.7z" "%DISTR_NAME%_%DATE_STAMP%%DATE_STAMP_SUFFIX%.7z"
    IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=905& GOTO RESULT_ERROR
    GOTO RENAME_DISTR_IS_DONE
)
:RENAME_DISTR_IS_DONE
 echo Rename is done



REM ===���� 10. �������� ��������� ������ � �����==================================================

REM ==============================================================================================
REM ===�������� ��������� ������ � �����==========================================================
REM ==============================================================================================
rmdir "%CLIENT_DISTR_PATH%\_update" /S /Q
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1001& GOTO RESULT_ERROR
del "%CLIENT_DISTR_PATH%\%DEVELOPER_CLOUD_REPOSITORY_FILENAME%"
IF NOT !ERRORLEVEL! == 0 SET ERROR_CODE=1002& GOTO RESULT_ERROR





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