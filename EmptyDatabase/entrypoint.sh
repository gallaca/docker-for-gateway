#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to be ready
echo "$DATABASE_NAME - Waiting for SQL Server to start..."
sleep 10
for i in {1..60}; do
  sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "$DATABASE_NAME - SQL Server is ready!"
    break
  fi
  echo "still waiting..."
  sleep 2
done

# Deploy the DACPAC
echo "Deploying DACPAC to $DATABASE_NAME database..."

sqlpackage \
  /Action:Publish \
  /SourceFile:/tmp/your-dacpac-file.dacpac \
  /TargetServerName:localhost \
  /TargetDatabaseName:$DATABASE_NAME \
  /TargetUser:sa \
  /TargetPassword:$SA_PASSWORD \
  /TargetTrustServerCertificate:True \
  /Variables:"Environment=$API_ENVIRONMENT"

echo "DACPAC deployment completed."

# Wait for SQL Server to exit
wait
