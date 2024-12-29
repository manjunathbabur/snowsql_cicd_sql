@echo off
REM Load environment variables
setlocal
call configs\config.env

REM Validate input1
if "%~1"=="" (
    echo Usage: run_sql.bat <sql_file>
    exit /b 1
)

set SQL_FILE=%~1

REM Execute SQL file using SnowSQL
snowsql -a %SNOWFLAKE_ACCOUNT% -u %SNOWFLAKE_USER% -p %SNOWFLAKE_PASSWORD% ^
  -w %SNOWFLAKE_WAREHOUSE% -d %SNOWFLAKE_DATABASE% ^
  -f %SQL_FILE%

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to execute %SQL_FILE%
    exit /b 1
)

echo Successfully executed %SQL_FILE%
