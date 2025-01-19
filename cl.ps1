Add-Type -AssemblyName System.Windows.Forms

# Função de exemplo (substitua com seus scripts reais)
function Execute-Op1 {
    Write-Host "Executando Opção 1..."
    # Coloque seu script ou função aqui
}

function Execute-Op2 {
    Write-Host "Executando Opção 2..."
    # Coloque outro script ou função aqui
}

# Cria uma nova janela (formulário)
$form = New-Object System.Windows.Forms.Form
$form.Text = "Painel de Controle"
$form.Size = New-Object System.Drawing.Size(400, 300)

# Cria um botão para a Opção 1
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Executar Opção 1"
$button1.Size = New-Object System.Drawing.Size(120, 40)
$button1.Location = New-Object System.Drawing.Point(50, 50)

# Função para quando o botão 1 for clicado
$button1.Add_Click({
    Execute-Op1
})

# Cria um botão para a Opção 2
$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Executar Opção 2"
$button2.Size = New-Object System.Drawing.Size(120, 40)
$button2.Location = New-Object System.Drawing.Point(50, 100)

# Função para quando o botão 2 for clicado
$button2.Add_Click({
    Execute-Op2
})

# Cria um botão para fechar o painel
$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Fechar"
$button3.Size = New-Object System.Drawing.Size(120, 40)
$button3.Location = New-Object System.Drawing.Point(50, 150)

# Função para fechar a janela
$button3.Add_Click({
    $form.Close()
})

# Adiciona os botões ao formulário
$form.Controls.Add($button1)
$form.Controls.Add($button2)
$form.Controls.Add($button3)

# Exibe a janela
$form.ShowDialog()
