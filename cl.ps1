# Painel Interativo em PowerShell

function Show-Menu {
    cls
    Write-Host "========== Painel de Controle ==========" -ForegroundColor Cyan
    Write-Host "1. Função 1: Exibir Data e Hora" -ForegroundColor Yellow
    Write-Host "2. Função 2: Listar Arquivos no Diretório Atual" -ForegroundColor Yellow
    Write-Host "3. Função 3: Testar Conexão com a Internet" -ForegroundColor Yellow
    Write-Host "4. Sair" -ForegroundColor Red
    Write-Host "========================================"
}

function Execute-Option1 {
    Write-Host "Data e Hora Atual:" (Get-Date) -ForegroundColor Green
    Pause
}

function Execute-Option2 {
    Write-Host "Arquivos no Diretório Atual:" -ForegroundColor Green
    Get-ChildItem | ForEach-Object { Write-Host $_.Name }
    Pause
}

function Execute-Option3 {
    Write-Host "Testando Conexão com a Internet..." -ForegroundColor Green
    try {
        $response = Test-Connection -ComputerName google.com -Count 1 -Quiet
        if ($response) {
            Write-Host "Conexão bem-sucedida!" -ForegroundColor Green
        } else {
            Write-Host "Falha na conexão." -ForegroundColor Red
        }
    } catch {
        Write-Host "Erro ao testar a conexão: $_" -ForegroundColor Red
    }
    Pause
}

# Loop Principal
do {
    Show-Menu
    $choice = Read-Host "Escolha uma opção"
    switch ($choice) {
        1 { Execute-Option1 }
        2 { Execute-Option2 }
        3 { Execute-Option3 }
        4 { Write-Host "Saindo..." -ForegroundColor Red; break }
        default { Write-Host "Opção inválida! Tente novamente." -ForegroundColor Red; Pause }
    }
} while ($true)
