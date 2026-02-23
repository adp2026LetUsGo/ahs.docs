
✔ AQUÍ TIENES EL SCRIPT CORRECTO PARA ELIMINAR EL DRIVER 31.x

``` powershell


Write-Host "Detectando INF de Intel HD Graphics..." -ForegroundColor Cyan

$intelDrivers = Get-CimInstance Win32_PnPSignedDriver `
    | Where-Object {
        $_.DriverProviderName -match "Intel" -and
        $_.DeviceName -match "Graphics|Display"
    } `
    | Select-Object DeviceName, DriverVersion, DriverDate, InfName

$intelDrivers

Write-Host "`nPresiona ENTER para continuar con la desinstalación del driver Intel..." -ForegroundColor Yellow
Read-Host

foreach ($inf in $intelDrivers.InfName) {
    Write-Host "Eliminando $inf ..." -ForegroundColor Red
    pnputil /delete-driver $inf /uninstall /force
}

Write-Host "`n✔ Driver desinstalado. AHORA REINICIA EL PC" -ForegroundColor Green
Write-Host "Después del reinicio, ejecuta e instala: 30.0.100.9865 (n1cdt52w.exe)"

```


# 📌 INSTRUCCIONES PRECISAS

1️⃣ **Ejecuta el script anterior (como administrador)**  
→ Esto detecta el driver Intel **y lo elimina** completamente del sistema.

2️⃣ **REINICIA el equipo**  
Cuando vuelvas a Windows, usarás la VGA básica (se verá simple por unos segundos).

3️⃣ **Ejecuta el instalador de Lenovo**  
→ `n1cdt52w.exe`  
→ Ese instalará correctamente **30.0.100.9865**  
→ Esta vez **sí se activará** porque el driver viejo ya no está.

4️⃣ **Valida otra vez con:**


``` powershell

Get-CimInstance Win32_VideoController | Select Name,DriverVersion,DriverDate

```


---

``` powershell

<#

.SYNOPSIS

  ThinkPad T560 (20ENCT01WW) – Corrección completa del driver Intel HD Graphics 530:

  - Bloquea reinstalación automática de drivers por Windows Update

  - Desinstala driver Intel DCH 31.x inestable (causa de crash dwm.exe)

  - Reinicia y luego instala driver Lenovo recomendado (30.0.100.9865 - n1cdt52w.exe)

  - Valida versión final y deja log en el Escritorio

  

.USO

  1) Edita $LenovoDriverExe si tu EXE está en otra ruta.

  2) Ejecuta como Administrador: PowerShell (x64) -> botón derecho -> Run as Administrator

  3) Si es necesario, habilita ejecución temporal: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

  4) Ejecuta: .\Fix-IntelHD530-T560.ps1

  

.NOTAS

  - Requiere reinicio automático entre fases.

  - Si la instalación silenciosa falla, lanzará el instalador en modo interactivo y te pedirá continuar.

#>

  

[CmdletBinding()]

param(

    [int]$Stage = 1,

    [string]$Driver,

    [string]$Expected

)

  

# ===================== CONFIG =====================

# Ruta del instalador oficial de Lenovo (ajusta si usas otra)

$LenovoDriverExe = "C:\Drivers\n1cdt52w.exe"

  

# Versión esperada por Lenovo para T560 (recomendada)

$ExpectedVersion = if ($Expected) { $Expected } else { "30.0.100.9865" }

  

# Si te pasan -Driver por parámetro, úsalo; si no, usa la constante

if ([string]::IsNullOrWhiteSpace($Driver)) { $Driver = $LenovoDriverExe }

  

# ===================== INFRA =====================

$ErrorActionPreference = 'Stop'

$ScriptSelf = $MyInvocation.MyCommand.Path

$Log = Join-Path $env:USERPROFILE ("Desktop\Fix-IntelHD530-T560_Log_{0}.txt" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))

  

function Log {

    param([Parameter(Mandatory=$true)][string]$Message, [ConsoleColor]$Color = [ConsoleColor]::White)

    $stamp = "[{0}] {1}" -f (Get-Date), $Message

    Write-Host $stamp -ForegroundColor $Color

    $stamp | Out-File -FilePath $Log -Append -Encoding utf8

}

  

function Require-Admin {

    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).

        IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {

        throw "Ejecuta este script como Administrador."

    }

}

  

function Make-RestorePoint {

    try {

        Log "Creando punto de restauración del sistema..." Cyan

        Checkpoint-Computer -Description "Pre Intel Driver Fix (T560)" -RestorePointType "MODIFY_SETTINGS"

        Log "Punto de restauración creado."

    } catch {

        Log "ADVERTENCIA: No se pudo crear el punto de restauración. $_" Yellow

    }

}

  

function Block-WU-DriverUpdates {

    try {

        Log "Bloqueando la instalación automática de drivers por Windows Update..." Cyan

        reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f | Out-Null

        Log "Clave 'ExcludeWUDriversInQualityUpdate' establecida a 1 (drivers excluidos de Windows Update)."

    } catch {

        Log "ADVERTENCIA: No se pudo aplicar bloqueo de drivers en Windows Update. $_" Yellow

    }

}

  

function Show-CurrentVideoDrivers {

    Log "Estado actual de controladores de video:" Cyan

    try {

        $vc = Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, DriverDate

        $vc | Format-Table | Out-String | ForEach-Object { Log $_ }

    } catch {

        Log "No se pudo enumerar Win32_VideoController. $_" Red

    }

}

  

function Get-IntelDisplaySignedDrivers {

    Log "Enumerando drivers Intel (clase Display) desde Win32_PnPSignedDriver..." Cyan

    $list = Get-CimInstance Win32_PnPSignedDriver |

        Where-Object {

            $_.ClassGuid -eq '{4d36e968-e325-11ce-bfc1-08002be10318}' -and

            ( $_.DriverProviderName -match 'Intel' -or $_.Manufacturer -match 'Intel' ) -and

            ( $_.DeviceName -match 'Graphics' -or $_.DeviceName -match 'Display' -or $_.DeviceName -match 'HD Graphics' )

        } |

        Select-Object DeviceName, DriverProviderName, Manufacturer, DriverVersion, DriverDate, InfName

    if ($list) {

        $list | Format-Table | Out-String | ForEach-Object { Log $_ }

    } else {

        Log "No se encontraron drivers Intel de Display en PnP Signed Driver."

    }

    return $list

}

  

function Uninstall-IntelDrivers {

    param([Parameter(Mandatory=$true)][string[]]$InfNames)

  

    foreach ($inf in ($InfNames | Select-Object -Unique)) {

        if (-not $inf.EndsWith('.inf')) { continue }

        try {

            Log "Desinstalando driver Intel: $inf ..." Red

            $proc = Start-Process -FilePath "pnputil.exe" -ArgumentList "/delete-driver `"$inf`" /uninstall /force" -NoNewWindow -Wait -PassThru

            Log "pnputil $inf → ExitCode=$($proc.ExitCode)"

        } catch {

            Log "ERROR al desinstalar $inf : $_" Red

        }

    }

}

  

function Schedule-Stage2-RunOnce {

    # Programar que el script continúe en Fase 2 cuando el usuario vuelva a iniciar sesión

    $cmd = "powershell.exe -ExecutionPolicy Bypass -File `"$ScriptSelf`" -Stage 2 -Driver `"$Driver`" -Expected `"$ExpectedVersion`""

    try {

        Log "Programando Fase 2 con RunOnce..." Cyan

        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Force | Out-Null

        New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "FixIntelT560" -Value $cmd -PropertyType String -Force | Out-Null

        Log "RunOnce configurado: $cmd"

    } catch {

        Log "ERROR al configurar RunOnce para Fase 2. $_" Red

        throw

    }

}

  

function Install-LenovoDriver {

    param([Parameter(Mandatory=$true)][string]$ExePath)

  

    if (-not (Test-Path $ExePath)) {

        throw "No se encontró el instalador en: $ExePath. Ajusta la variable o usa -Driver 'ruta\al\exe'."

    }

  

    Log "Instalando driver Lenovo desde: $ExePath" Cyan

  

    $silentArgs = @("/S", "/s", "/VERYSILENT", "/silent")

    $installed = $false

  

    foreach ($arg in $silentArgs) {

        try {

            Log "Intento de instalación silenciosa con argumento: $arg"

            $p = Start-Process -FilePath $ExePath -ArgumentList $arg -Wait -PassThru

            Log "Instalador finalizó con ExitCode=$($p.ExitCode)"

            if ($p.ExitCode -eq 0) { $installed = $true; break }

        } catch {

            Log "Fallo intento silencioso ($arg): $_" Yellow

        }

    }

  

    if (-not $installed) {

        Log "No fue posible instalar en modo silencioso. Lanzando en modo interactivo..." Yellow

        Start-Process -FilePath $ExePath

        Read-Host ">>> Completa la instalación manualmente y presiona [Enter] para continuar con la verificación..."

    }

  

    Log "Instalación del paquete Lenovo completada (silenciosa o manual)."

}

  

function Verify-IntelVersion {

    Log "Verificando versión de driver Intel HD Graphics..." Cyan

    try {

        $intel = Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "Intel" }

        if (-not $intel) {

            Log "❌ No se detectó GPU Intel en Win32_VideoController." Red

            return $false

        }

        $msg = "Detectado → {0}  |  DriverVersion={1}  |  DriverDate={2}" -f $intel.Name, $intel.DriverVersion, $intel.DriverDate

        Log $msg

  

        if ($intel.DriverVersion -eq $ExpectedVersion) {

            Log "✔ DRIVER CORRECTO INSTALADO: $($intel.DriverVersion)" Green

            return $true

        } else {

            Log "❌ VERSIÓN NO COINCIDE. Actual=$($intel.DriverVersion)  Esperada=$ExpectedVersion" Red

            return $false

        }

    } catch {

        Log "ERROR comprobando versión Intel. $_" Red

        return $false

    }

}

  

# ===================== FLUJO PRINCIPAL =====================

try {

    Require-Admin

    Log "=== Fix Intel HD 530 – ThinkPad T560 – Fase $Stage ===" Cyan

  

    if ($Stage -eq 1) {

        Log "Fase 1: bloquear WU drivers + desinstalar Intel + reiniciar." Cyan

  

        Make-RestorePoint

        Block-WU-DriverUpdates

        Show-CurrentVideoDrivers

  

        $intelPnP = Get-IntelDisplaySignedDrivers

        if ($intelPnP -and $intelPnP.InfName) {

            Uninstall-IntelDrivers -InfNames $intelPnP.InfName

        } else {

            Log "No se encontraron INF Intel para desinstalar (PnP). Continuando..."

        }

  

        # Programar Fase 2

        Schedule-Stage2-RunOnce

  

        Log "Reiniciando el equipo para completar la desinstalación..." Yellow

        Start-Sleep -Seconds 2

        Restart-Computer -Force

        return

    }

  

    if ($Stage -eq 2) {

        Log "Fase 2: instalar driver Lenovo y validar." Cyan

  

        Show-CurrentVideoDrivers

  

        # Instalar el driver Lenovo indicado

        Install-LenovoDriver -ExePath $Driver

  

        # Sugerir reinicio (no siempre es estrictamente necesario, pero recomendado)

        try {

            $resp = Read-Host "¿Deseas reiniciar ahora para finalizar? (Y/N)"

            if ($resp -match '^(Y|y|S|s)$') {

                Log "Reiniciando el equipo..." Yellow

                Restart-Computer -Force

            } else {

                Log "Reinicio pospuesto por el usuario."

            }

        } catch {

            Log "No se pudo reiniciar automáticamente. $_" Yellow

        }

  

        # Verificación (si no reiniciaste, puede mostrar aún versión antigua en memoria)

        $ok = Verify-IntelVersion

        if (-not $ok) {

            Log "Si la versión no coincide, reinicia manualmente y vuelve a ejecutar SOLO la verificación:" Yellow

            Log '  Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "Intel" } | Select Name, DriverVersion, DriverDate'

        }

  

        Log "=== Proceso completado. Log guardado en: $Log ===" Green

        return

    }

  

    Log "Parámetro -Stage desconocido ($Stage). Finalizando." Red

  

} catch {

    Log "ERROR FATAL: $_" Red

    throw

}

```