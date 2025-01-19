# Função para exibir o menu
function Show-Menu {
    Clear-Host
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "       Painel CL        " -ForegroundColor Green
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "1. Instalar Pacote CL" -ForegroundColor Yellow
    Write-Host "2. Sair" -ForegroundColor Yellow
    Write-Host "========================" -ForegroundColor Cyan
}

# Função para instalar o pacote CL
function Install-CL {
    Write-Host "Iniciando instalação do pacote CL..." -ForegroundColor Green
    
    # URL do ZIP no Google Drive
    $zipUrl = "https://drive.google.com/uc?export=download&id=1xLWkNOa1T3UTfEbUe9AnDrcbJBjqbfBU"
    $destFolder = "C:\InstallPrograms"
    $zipFile = "$destFolder\programs.zip"

    # Cria a pasta de destino
    if (-not (Test-Path -Path $destFolder)) {
        New-Item -ItemType Directory -Path $destFolder
    }

    # Baixa o arquivo ZIP
    Write-Host "Baixando o pacote CL..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile

    # Extrai os arquivos do ZIP
    Write-Host "Extraindo os arquivos do pacote CL..." -ForegroundColor Cyan
    Expand-Archive -Path $zipFile -DestinationPath $destFolder -Force

    # Instalação dos programas
    Write-Host "Instalando os programas do pacote CL..." -ForegroundColor Green

    # Google Chrome
    $chromePath = Join-Path $destFolder "google-chrome.exe"
    if (Test-Path -Path $chromePath) {
        Start-Process -FilePath $chromePath -ArgumentList "/silent /install" -Wait
        Write-Host "Google Chrome instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo google-chrome.exe não encontrado!" -ForegroundColor Red
    }

    # AnyDesk
    $anydeskPath = Join-Path $destFolder "anydesk.exe"
    if (Test-Path -Path $anydeskPath) {
        Start-Process -FilePath $anydeskPath -ArgumentList "/silent" -Wait
        Write-Host "AnyDesk instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo anydesk.exe não encontrado!" -ForegroundColor Red
    }

    # ZIP Tool
    $zipToolPath = Join-Path $destFolder "zip.exe"
    if (Test-Path -Path $zipToolPath) {
        Start-Process -FilePath $zipToolPath -ArgumentList "/S" -Wait
        Write-Host "Ferramenta ZIP instalada com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo zip.exe não encontrado!" -ForegroundColor Red
    }

    # Adobe Reader (versão baseada no Windows)
    $osVersion = (Get-WmiObject -Class Win32_OperatingSystem).Version
    if ($osVersion -like "10.*") {
        $adobePath = Join-Path $destFolder "adobe-reader-11.exe"
        Write-Host "Windows 10/11 detectado, instalando Adobe Reader 11..." -ForegroundColor Cyan
    } else {
        $adobePath = Join-Path $destFolder "adobe-reader-10.exe"
        Write-Host "Versão mais antiga do Windows detectada, instalando Adobe Reader 10..." -ForegroundColor Cyan
    }

    if (Test-Path -Path $adobePath) {
        Start-Process -FilePath $adobePath -ArgumentList "/silent" -Wait
        Write-Host "Adobe Reader instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo Adobe Reader não encontrado!" -ForegroundColor Red
    }

    # Limpeza
    Remove-Item -Path $zipFile -Force
    Write-Host "Pacote CL instalado com sucesso e arquivos temporários removidos!" -ForegroundColor Green
    Pause
}

# Loop do menu principal
do {
    Show-Menu
    $choice = Read-Host "Digite a opção desejada"

    switch ($choice) {
        "1" {
            Install-CL
        }
        "2" {
            Write-Host "Saindo do Painel CL. Até mais!" -ForegroundColor Cyan
            break
        }
        default {
            Write-Host "Opção inválida! Tente novamente." -ForegroundColor Red
            Pause
        }
    }
} while ($choice -ne "2")
