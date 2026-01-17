@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   Instalação do Ambiente Tainacan
echo ==========================================
echo.

:: Verificar se Docker está instalado
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Docker não está instalado!
    echo.
    echo Por favor, instale o Docker Desktop:
    echo https://www.docker.com/products/docker-desktop/
    echo.
    pause
    exit /b 1
)

echo Docker encontrado!
echo.

:: Verificar se Docker está rodando
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Docker não está rodando!
    echo.
    echo Por favor, inicie o Docker Desktop e tente novamente.
    echo.
    pause
    exit /b 1
)

echo Docker está rodando!
echo.

:: Iniciar containers
echo Iniciando containers (isso pode demorar na primeira vez)...
echo.
docker-compose up -d

if %errorlevel% neq 0 (
    echo.
    echo ERRO: Falha ao iniciar os containers.
    pause
    exit /b 1
)

echo.
echo Containers iniciados! Aguardando 15 segundos...
timeout /t 15 /nobreak >nul

:: Executar setup
echo.
echo Executando configuração do WordPress e Tainacan...
echo.
docker exec tainacan-wordpress setup-tainacan.sh

if %errorlevel% neq 0 (
    echo.
    echo AVISO: Houve um problema no setup. Tente executar manualmente:
    echo docker exec tainacan-wordpress setup-tainacan.sh
    echo.
)

echo.
echo ==========================================
echo   INSTALAÇÃO CONCLUÍDA!
echo ==========================================
echo.
echo   Acesse: http://localhost:8080
echo   Admin:  http://localhost:8080/wp-admin
echo.
echo   Usuário: admin
echo   Senha:   tainacan123
echo.
echo ==========================================
echo.
pause
