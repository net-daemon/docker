FROM mcr.microsoft.com/dotnet/sdk:6.0

ENV \
    S6_KEEP_ENV=1 \
    DOTNET_NOLOGO=true \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    HASSCLIENT_MSGLOGLEVEL=Default \
    HOMEASSISTANT__HOST=localhost \
    HOMEASSISTANT__PORT=8123 \
    HOMEASSISTANT__TOKEN=NOT_SET \
    NETDAEMON__ADMIN=false \
    ASPNETCORE_URLS=http://+:5000 \
    # For V2
    NETDAEMON__APPSOURCE=/data \            
    # For V3
    NETDAEMON__APPLICATION_CONFIGURATION_FOLDER=/data 

# This one is used by the container to start custom assembly
#NETDAEMON__APPLICATION_ASSEMBLY="" 

# Install S6 and the Admin site
RUN apt update && apt install -y \
    nodejs \
    yarn \
    jq \
    make

COPY ./base/s6.sh /s6.sh

RUN chmod 700 /s6.sh
RUN /s6.sh

ENTRYPOINT ["/init"]