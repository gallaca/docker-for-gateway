FROM mcr.microsoft.com/mssql/server:2019-latest

# Switch to root to install packages
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
  unzip \
  libunwind8 \
  libicu-dev \
  wget

# Download and install sqlpackage
RUN wget -O sqlpackage.zip https://aka.ms/sqlpackage-linux \
  && unzip sqlpackage.zip -d /opt/sqlpackage \
  && chmod +x /opt/sqlpackage/sqlpackage \
  && ln -s /opt/sqlpackage/sqlpackage /usr/bin/sqlpackage
  
# Switch back to default user
USER mssql

# Copy DACPAC and script
COPY xxxxxxxxx /tmp/your-dacpac-file.dacpac
COPY --chmod=+x entrypoint.sh /tmp/entrypoint.sh

CMD /bin/bash /tmp/entrypoint.sh
