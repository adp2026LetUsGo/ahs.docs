# ================================================================
#  Create AHS.KnowledgeCore Directory Structure
#  Safe version – validates existence before creating
# ================================================================

# Ruta raíz donde se creará el Knowledge Core
$root = Join-Path -Path (Get-Location) -ChildPath "AHS.KnowledgeCore"

# Listado de subdirectorios requeridos
$subdirs = @(
    "Blueprints",
    "Skills",
    "Prompts",
    "Cells",
    "Canvas",
    "Manifests",
    "SystemInstructions",
    "AI"
)

Write-Host ""
Write-Host ">>> AHS.KnowledgeCore: Verificando estructura..." -ForegroundColor Cyan
Write-Host ""

# Validar si el directorio raíz existe
if (Test-Path $root) {
    Write-Host "⚠ El directorio '$root' ya existe. No se creará nuevamente." -ForegroundColor Yellow
    Write-Host "   (No se sobrescribe para evitar pérdida de datos)"
    Write-Host ""
}
else {
    # Crear directorio principal
    New-Item -Path $root -ItemType Directory | Out-Null
    Write-Host "✔ Creado: $root" -ForegroundColor Green
}

# Crear subdirectorios
foreach ($dir in $subdirs) {

    $fullPath = Join-Path $root $dir

    if (Test-Path $fullPath) {
        Write-Host "   • Existe: $dir (OK)" -ForegroundColor DarkYellow
    }
    else {
        New-Item -Path $fullPath -ItemType Directory | Out-Null
        Write-Host "   ✔ Creado: $dir" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host ">>> Estructura AHS.KnowledgeCore verificada/completada." -ForegroundColor Cyan
Write-Host ""