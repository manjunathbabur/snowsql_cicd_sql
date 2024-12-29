@echo off
REM Load environment variables
setlocal
call configs\config.env

REM Validate input
if "%~1"=="" (
    echo Usage: run_sql.bat <sql_file>
    exit /b 1
)

set SQL_FILE=%~1
set RETRY_COUNT=3
set RETRY_DELAY=10

echo [%DATE% %TIME%] Starting execution of %SQL_FILE%

REM Retry logic for SQL execution
for /L %%i in (1, 1, %RETRY_COUNT%) do (
    snowsql -a %SNOWFLAKE_ACCOUNT% -u %SNOWFLAKE_USER% -p %SNOWFLAKE_PASSWORD% ^
        -w %SNOWFLAKE_WAREHOUSE% -d %SNOWFLAKE_DATABASE% -f %SQL_FILE% --debug

    if %ERRORLEVEL% EQU 0 (
        echo [%DATE% %TIME%] Successfully executed %SQL_FILE% on attempt %%i
        exit /b 0
    )

    echo [%DATE% %TIME%] Attempt %%i failed. Retrying in %RETRY_DELAY% seconds...
    timeout /t %RETRY_DELAY% > nul
)

echo [%DATE% %TIME%] Failed to execute %SQL_FILE% after %RETRY_COUNT% attempts.
exit /b 1
