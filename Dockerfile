# Etap bazowy – środowisko uruchomieniowe
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app

# Etap builda – SDK do kompilacji
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Skopiuj tylko potrzebną część repo
COPY ./src/SimpleApi ./SimpleApi

# Przejdź do folderu z projektem
WORKDIR /src/SimpleApi

# Przywracanie zależności
RUN dotnet restore SimpleApi.csproj

# Publikacja aplikacji
RUN dotnet publish -c Release -o /out

# Etap finalny – gotowa aplikacja w obrazie uruchomieniowym
FROM base AS final
WORKDIR /app
COPY --from=build /out .

ENTRYPOINT ["dotnet", "SimpleApi.dll"]