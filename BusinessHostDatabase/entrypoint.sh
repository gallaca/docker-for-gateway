#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to be ready
sleep 10
echo "Waiting for SQL Server to start..."
for i in {1..60}; do
  sqlcmd -S localhost -U sa -P 'YourStrong!Passw0rd' -Q "SELECT 1" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "SQL Server is ready!"
    break
  fi
  echo "Still waiting for SQL Server..."
  sleep 2
done

# Deploy the DACPAC
sqlpackage \
  /Action:Publish \
  /SourceFile:/tmp/your-dacpac-file.dacpac \
  /TargetServerName:localhost \
  /TargetDatabaseName:BusinessHost \
  /TargetUser:sa \
  /TargetPassword:YourStrong!Passw0rd \
  /TargetTrustServerCertificate:True

# /usr/bin/sqlcmd -S localhost -U sa -P YourStrong!Passw0rd -i /tmp/setup.sql

# Wait for SQL Server to exit
wait
