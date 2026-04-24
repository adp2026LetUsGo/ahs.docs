# =====================================================================
#  AHS JSON → Markdown Converter (FINAL VERSION)
#  Sin ConvertFrom-Json, sin Depth, compatible con PS 5 y 7.
# =====================================================================

# 1. ORIGEN
$origen  = 'C:\Users\armando\Downloads\03.a.AHS.Antigravity.Implementation.Specs.json'

# 2. DESTINO
$destino = 'C:\Users\armando\Documents\_AHS\ahs.docs\00_Inbox\03.a.AHS.Antigravity.Implementation.Specs.md'

# =====================================================================
# NO EDITAR DEBAJO
# =====================================================================

Write-Host ''
Write-Host 'Leyendo JSON con System.Text.Json...' -ForegroundColor Cyan

Add-Type -AssemblyName System.Text.Json

# Leemos el archivo como texto crudo
$jsonText = Get-Content -Raw -Encoding UTF8 $origen

# Parseamos usando System.Text.Json
$options = [System.Text.Json.JsonDocumentOptions]::new()
$options.AllowTrailingCommas = $true

$doc = [System.Text.Json.JsonDocument]::Parse($jsonText, $options)

# Lista donde acumularemos el texto encontrado
$resultado = New-Object System.Collections.Generic.List[string]

function Explorar {
    param($node)

    switch ($node.ValueKind) {

        'String' {
            $texto = $node.GetString().Trim()
            if ($texto.Length -gt 0) {
                $resultado.Add($texto)
            }
        }

        'Object' {
            foreach ($prop in $node.EnumerateObject()) {
                Explorar $prop.Value
            }
        }

        'Array' {
            foreach ($item in $node.EnumerateArray()) {
                Explorar $item
            }
        }
    }
}

Explorar $doc.RootElement

Write-Host 'Generando Markdown...' -ForegroundColor Yellow

$md = @()
$md += '# Extracted Markdown Document'
$md += '---'
$md += ''

foreach ($linea in $resultado) {

    # Limpieza básica segura
    $clean = $linea.Replace('\n', "`n")
    $clean = $clean.Replace('\t', "    ")
    $clean = $clean.Replace('\"', '"')
    $clean = $clean.Replace('\\\\', '\')

    $md += $clean
    $md += ''
    $md += '---'
    $md += ''
}

$md -join "`n" | Set-Content -Encoding UTF8 $destino

Write-Host ''
Write-Host '✔ Conversión completa.' -ForegroundColor Green
Write-Host 'Archivo MD creado en:' -ForegroundColor White
Write-Host $destino -ForegroundColor Magenta
Write-Host ''