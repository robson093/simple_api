# Etap bazowy – środowisko uruchomieniowe
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app

# Etap builda – SDK do kompilacji
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Skopiuj całą zawartość repo do obrazu
COPY ./src/SimpleApi ./SimpleApi

# Przywracanie zależności
RUN dotnet restore src/SimpleApi/SimpleApi.csproj

# Publikacja aplikacji do folderu /out
WORKDIR /SimpleApi
RUN dotnet publish -c Release -o /out

# Etap finalny – gotowa aplikacja w obrazie uruchomieniowym
FROM base AS final
WORKDIR /app
COPY --from=build /out .

ENTRYPOINT ["dotnet", "SimpleApi.dll"]