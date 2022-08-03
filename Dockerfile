# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

WORKDIR /app

COPY . .

RUN dotnet tool install --global dotnet-ef --version 5.0.0
RUN dotnet restore
RUN dotnet tool restore
RUN dotnet new tool-manifest
RUN dotnet tool update dotnet-ef
RUN dotnet publish -c Release -o out 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "WebGoatCore.dll"]
