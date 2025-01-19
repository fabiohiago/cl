function Install-CL {
    $zipUrl = "https://drive.usercontent.google.com/download?id=1xLWkNOa1T3UTfEbUe9AnDrcbJBjqbfBU&export=download&authuser=0&confirm=t&uuid=66703122-acac-4982-a225-d9f27f244007&at=AIrpjvM-h_ZbDn6ITUkQgxBCWB_4%3A1737311713746"
    $destFolder = "C:\InstallPrograms"
    $zipFile = "$destFolder\programs.zip"

    # Criar pasta de destino
    if (-not (Test-Path -Path $destFolder)) {
        New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
    }

    # Baixar o ZIP
    Write-Host "Baixando o pacote CL..." -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile
        Write-Host "Pacote CL baixado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "Falha no download do pacote CL: $_" -ForegroundColor Red
        return
    }

    # Verificar se o arquivo ZIP existe
    if (-not (Test-Path -Path $zipFile)) {
        Write-Host "Erro: O arquivo ZIP não foi baixado corretamente!" -ForegroundColor Red
        return
    }

    # Extrair os arquivos do ZIP
    try {
        Write-Host "Extraindo os arquivos do pacote CL..." -ForegroundColor Cyan
        Expand-Archive -Path $zipFile -DestinationPath $destFolder -Force
        Write-Host "Arquivos extraídos com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "Erro ao extrair o pacote CL: $_" -ForegroundColor Red
        return
    }

    # Instalar os programas
    $programs = @("google-chrome.exe", "anydesk.exe", "zip.exe")
    foreach ($program in $programs) {
        $filePath = Join-Path -Path $destFolder -ChildPath $program
        if (Test-Path -Path $filePath) {
            Write-Host "Instalando $program..." -ForegroundColor Cyan
            Start-Process -FilePath $filePath -ArgumentList "/silent" -Wait
            Write-Host "$program instalado com sucesso!" -ForegroundColor Green
        } else {
            Write-Host "Arquivo $program não encontrado!" -ForegroundColor Red
        }
    }

    # Verificar e instalar Adobe Reader
    if ((Get-WmiObject -Class Win32_OperatingSystem).Version -match "10|11") {
        $adobeVersion = "adobe-reader-11.exe"
    } else {
        $adobeVersion = "adobe-reader-10.exe"
    }

    $adobePath = Join-Path -Path $destFolder -ChildPath $adobeVersion
    if (Test-Path -Path $adobePath) {
        Write-Host "Instalando Adobe Reader ($adobeVersion)..." -ForegroundColor Cyan
        Start-Process -FilePath $adobePath -ArgumentList "/silent" -Wait
        Write-Host "Adobe Reader instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo Adobe Reader não encontrado!" -ForegroundColor Red
    }

    # Limpar arquivos temporários
    Remove-Item -Path $zipFile -Force
    Write-Host "Pacote CL instalado com sucesso e arquivos temporários removidos!" -ForegroundColor Green
}

# Executar a função
Install-CL
