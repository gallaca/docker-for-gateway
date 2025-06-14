FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Yes

# Switch to root to install packages
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
  unzip \
  libunwind8 \
  libicu-dev \
  wget \
  gnupg \
  curl \
  apt-transport-https
  
# Install Microsoft SQL Server command-line tools (sqlcmd)
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
  && curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
  && ln -s /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd \
  && rm microsoft.gpg

  # Download and install sqlpackage
RUN wget -O sqlpackage.zip https://aka.ms/sqlpackage-linux \
  && unzip sqlpackage.zip -d /opt/sqlpackage \
  && chmod +x /opt/sqlpackage/sqlpackage \
  && ln -s /opt/sqlpackage/sqlpackage /usr/bin/sqlpackage

# Start SQL Server
CMD /opt/mssql/bin/sqlservr
