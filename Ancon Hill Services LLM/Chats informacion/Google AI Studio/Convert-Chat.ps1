# 1. Define the path to your exported file (without extension)
$inputFile = "C:\Users\armando\Downloads\Delaware Business Tax Obligations"
$outputFile = "C:\Users\armando\Documents\_AHS\ahs.docs\Ancon Hill Services LLM\Chats informacion\Google AI Studio\Clean_Chat.txt"


# 2. Cargar el JSON
$data = Get-Content -Raw -Path $inputFile | ConvertFrom-Json

# 3. Función para buscar mensajes recursivamente
# Esto busca en todo el archivo la palabra "content" o "text"
function Get-ChatText($Object) {
    if ($Object -is [Array]) {
        foreach ($item in $Object) { Get-ChatText $item }
    }
    elseif ($Object -is [PSCustomObject]) {
        # Si tiene 'role' y 'parts', es el formato estándar de Gemini
        if ($Object.role -and $Object.parts) {
            "[$($Object.role.ToUpper())]:`n$($Object.parts.text -join ' ')`n"
        }
        # Si es un formato más simple
        elseif ($Object.content) {
            "Content:`n$($Object.content)`n"
        }
        # Seguir buscando en niveles más profundos
        foreach ($prop in $Object.PSObject.Properties) {
            Get-ChatText $prop.Value
        }
    }
}

# 4. Ejecutar y Guardar
$result = Get-ChatText $data | Where-Object { $_ -ne $null }
$result | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Proceso terminado. Revisa: $outputFile" -ForegroundColor Cyan