FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base
USER $APP_UID
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["ContainerCPUStress/ContainerCPUStress.csproj", "ContainerCPUStress/"]
RUN dotnet restore "ContainerCPUStress/ContainerCPUStress.csproj"
COPY . .
WORKDIR "/src/ContainerCPUStress"
RUN dotnet build "ContainerCPUStress.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "ContainerCPUStress.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ContainerCPUStress.dll"]
