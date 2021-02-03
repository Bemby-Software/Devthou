FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
EXPOSE 80

# Copy and publish 
COPY . .
RUN dotnet publish -c release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "Devthou.Api.dll"]