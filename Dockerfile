# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./
RUN dotnet publish -c Release -o /out

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:9.0

# Set the working directory
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /out .

# Expose the port the app runs on
EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "SimpleApi.dll"]