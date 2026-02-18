<#
.SYNOPSIS
Genera dos árboles de directorios para AHS.DevKnowledge:
 - _tree_folders.txt  : Solo carpetas (profundidad limitada)
 - _tree_full.txt     : Carpetas + archivos (profundidad ilimitada)
Crea el directorio _docs si no existe.

#>

[CmdletBinding()]
param(
    [string]$RootPath = "C:\Users\armando\Documents\AHS.DevKnowledge",
    [int]$FolderDepth = 3,
    [string[]]$ExcludeDirs = @("bin","obj",".git",".vs","node_modules",".obsidian","__pycache__","dist","build")
)

# === Preparación de rutas de salida ===
$docsDir   = Join-Path $RootPath "_docs"
$outFolder = Join-Path $docsDir  "_tree_folders.txt"
$outFull   = Join-Path $docsDir  "_tree_full.txt"

if (-not (Test-Path -LiteralPath $RootPath)) {
    throw "La ruta '$RootPath' no existe."
}

if (-not (Test-Path -LiteralPath $docsDir)) {
    New-Item -ItemType Directory -Path $docsDir | Out-Null
}

# === Utilidad: ¿Directorio excluido? ===
function Test-IsExcluded {
    param(
        [System.IO.DirectoryInfo]$Dir,
        [string[]]$ExcludeNames
    )
    # Se compara por nombre de carpeta (último segmento)
    return $ExcludeNames -contains $Dir.Name
}

# === Árbol 1: Solo carpetas (profundidad limitada) ===
function Write-FolderTree {
    param(
        [string]$Path,
        [int]$Depth,
        [string[]]$ExcludeNames,
        [string]$Output
    )

    $lines = New-Object System.Collections.Generic.List[string]

    function Add-Dir {
        param(
            [System.IO.DirectoryInfo]$Dir,
            [int]$Level
        )

        if ($Level -eq 0) {
            $lines.Add($Dir.FullName)  # raíz
        } else {
            $indent = ('│   ' * ($Level - 1))
            $lines.Add("$indent├── $($Dir.Name)")
        }

        if ($Level -ge $Depth) { return }

        $children = Get-ChildItem -LiteralPath $Dir.FullName -Directory -ErrorAction SilentlyContinue |
                    Where-Object { -not (Test-IsExcluded -Dir $_ -ExcludeNames $ExcludeNames) } |
                    Sort-Object Name

        foreach ($c in $children) {
            Add-Dir -Dir $c -Level ($Level + 1)
        }
    }

    $root = Get-Item -LiteralPath $Path
    Add-Dir -Dir $root -Level 0

    $lines | Out-File -FilePath $Output -Encoding utf8
}

# === Árbol 2: Carpetas + archivos (profundidad ilimitada) ===
function Write-FullTree {
    param(
        [string]$Path,
        [string[]]$ExcludeNames,
        [string]$Output
    )
    $lines = New-Object System.Collections.Generic.List[string]

    function Add-Dir {
        param(
            [System.IO.DirectoryInfo]$Dir,
            [int]$Level
        )

        if ($Level -eq 0) {
            $lines.Add($Dir.FullName)  # raíz
        } else {
            $indent = ('│   ' * ($Level - 1))
            $lines.Add("$indent├── $($Dir.Name)")
        }

        # Archivos en el nivel actual
        $files = Get-ChildItem -LiteralPath $Dir.FullName -File -ErrorAction SilentlyContinue | Sort-Object Name
        foreach ($f in $files) {
            $indent = ('│   ' * $Level)
            $lines.Add("$indent├── $($f.Name)")
        }

        # Subdirectorios (respetando exclusiones)
        $children = Get-ChildItem -LiteralPath $Dir.FullName -Directory -ErrorAction SilentlyContinue |
                    Where-Object { -not (Test-IsExcluded -Dir $_ -ExcludeNames $ExcludeNames) } |
                    Sort-Object Name

        foreach ($c in $children) {
            Add-Dir -Dir $c -Level ($Level + 1)
        }
    }

    $root = Get-Item -LiteralPath $Path
    Add-Dir -Dir $root -Level 0

    $lines | Out-File -FilePath $Output -Encoding utf8
}

# === Ejecución ===
Write-Host "Generando árbol SOLO CARPETAS (profundidad $FolderDepth)..."
Write-FolderTree -Path $RootPath -Depth $FolderDepth -ExcludeNames $ExcludeDirs -Output $outFolder
Write-Host "OK -> $outFolder"

Write-Host "Generando árbol COMPLETO (carpetas + archivos)..."
Write-FullTree -Path $RootPath -ExcludeNames $ExcludeDirs -Output $outFull
Write-Host "OK -> $outFull"

Write-Host "Finalizado."