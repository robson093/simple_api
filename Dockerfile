# Etap bazowy – środowisko uruchomieniowe - nie trzeba go używać, można bezpośrednio w finalnym etapie obraz podpina
# base używać wtedy, kiedy potrzebne są bardziej złożone obrazy lub dodatkowe zależności np. apt get itd
#FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
#WORKDIR /app

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
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "SimpleApi.dll"]