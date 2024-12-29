#!/bin/bash

# Load environment variables
source ./configs/config.env

# Check for SQL file argument
if [ -z "$1" ]; then
  echo "Usage: $0 <sql_file>"
  exit 1
fi

SQL_FILE=$1

# Execute SQL file using SnowSQL
snowsql -a $SNOWFLAKE_ACCOUNT -u $SNOWFLAKE_USER -p $SNOWFLAKE_PASSWORD \
  -w $SNOWFLAKE_WAREHOUSE -d $SNOWFLAKE_DATABASE \
  -q "source ${SQL_FILE}"

if [ $? -ne 0 ]; then
  echo "Error: Failed to execute $SQL_FILE"
  exit 1
fi

echo "Successfully executed $SQL_FILE"
