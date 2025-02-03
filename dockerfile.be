# 使用官方 .NET 8.0 SDK 镜像作为构建阶段
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 复制项目文件并还原依赖
COPY *.csproj ./
RUN dotnet restore

# 复制所有源文件并构建发布包
COPY . ./
RUN dotnet publish -c Release

# 使用官方 .NET 8.0 Runtime 镜像作为运行阶段
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# 从构建阶段复制发布文件到运行时镜像
COPY --from=build /app/bin/Release/net8.0/ ./

# 暴露端口（应用程序在 5180 端口运行）
EXPOSE 5180


# 定义构建时传入的参数，并设置 ASPNETCORE_ENVIRONMENT
ARG ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_ENVIRONMENT=$ASPNETCORE_ENVIRONMENT

# 修改应用监听端口
ENV ASPNETCORE_URLS=http://+:5180 

# 设置容器启动命令
ENTRYPOINT ["dotnet", "MeetlyOmni.dll"]

# 定义可选的构建参数来指定镜像标签
# docker build --build-arg ASPNETCORE_ENVIRONMENT=Development --build-arg TAG=dev -t meetlyomni-backend:dev .
# docker build --build-arg ASPNETCORE_ENVIRONMENT=Production --build-arg TAG=prod -t meetlyomni-backend:prod .
ARG TAG=latest
LABEL version=$TAG
