#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to be ready
echo "Waiting for SQL Server to start..."
sleep 10
for i in {1..60}; do
  sqlcmd -S localhost -U sa -P 'YourStrong!Passw0rd' -Q "SELECT 1" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "SQL Server is ready!"
    break
  fi
  echo "still waiting..."
  sleep 2
done

# Deploy the DACPAC
echo "Deploying DACPAC to ConsumerApi database..."

sqlpackage \
  /Action:Publish \
  /SourceFile:/tmp/your-dacpac-file.dacpac \
  /TargetServerName:localhost \
  /TargetDatabaseName:GatewayApi \
  /TargetUser:sa \
  /TargetPassword:YourStrong!Passw0rd \
  /TargetTrustServerCertificate:True

echo "DACPAC deployment completed."

# Wait for SQL Server to exit
wait
