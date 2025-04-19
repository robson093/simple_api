# Etap bazowy – środowisko uruchomieniowe
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app

# Etap builda – SDK do kompilacji
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Skopiuj projekt
COPY ./src/SimpleApi/ ./SimpleApi/

# Przywróć zależności i opublikuj
WORKDIR /src/SimpleApi
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Etap finalny – gotowa aplikacja
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "SimpleApi.dll"]