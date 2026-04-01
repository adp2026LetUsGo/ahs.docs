
Si la **instalación del driver falla** (o no queda activa tras el reinicio), aquí tienes **qué hacer**, en orden de menor a mayor intervención, con **comandos y scripts** para cada caso.

***

## 0) Lo primero: entender “cómo falló”

Identifica el síntoma para aplicar el remedio correcto:

*   **El instalador termina con error** (mensaje / código ≠ 0).
*   **El instalador termina “bien” pero tras reiniciar sigues con 31.x** (Windows mantuvo el driver viejo).
*   **Pantalla negra/parpadeos** tras instalar → probablemente conflicto/cola de reinstalación de Windows Update o restos de driver.

> Nuestro script ya deja un **log en Escritorio**. Revisa si indica:
>
> *   *“ExitCode del instalador”*
> *   *“Versión detectada”*

***

## 1) Reintentar instalación en **modo interactivo** y forzar INF manual

Algunos paquetes `.exe` de Lenovo fallan en modo silencioso o no reemplazan DCH 31.x si aún hay restos. Haz esto:

### 1.1 Ejecutar de forma interactiva

1.  Descarga el EXE (`n1cdt52w.exe`) y ejecútalo **sin argumentos**.
2.  Completa el asistente → **reinicia**.

### 1.2 Instalar INF manualmente (si el asistente dice “instalado” pero no cambia la versión)

Los paquetes Lenovo suelen **descomprimir** en `C:\DRIVERS\WIN\VIDEO\INTEL` o similar.

*   Ubica la carpeta que contiene `igdlh64.inf` / `igfx…inf` (varía).
*   Instala “a mano” con `pnputil`:

```powershell
# Cambia la ruta a la carpeta donde está el INF correcto del paquete Lenovo
$infPath = "C:\DRIVERS\WIN\VIDEO\INTEL\igdlh64.inf"
pnputil /add-driver "$infPath" /install
```

> Si tienes varias `.inf`, instala la principal (la que hace referencia a “HD Graphics 530”).  
> **Reinicia** y vuelve a validar:

```powershell
Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "Intel" } | Select Name, DriverVersion, DriverDate
```

***

## 2) Asegurar que **Windows Update NO reinstale** el driver malo (31.x)

Incluso si instalas el Lenovo correcto, Windows puede **reponer** el 31.x en segundo plano. Asegura el bloqueo:

```powershell
# Bloquear drivers en Windows Update (política por Registro)
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f

# (Pro/Enterprise) Política equivalente:
# gpedit.msc → Computer Configuration → Administrative Templates → Windows Update → Do not include drivers with Windows Updates → Enabled
```

Además, **oculta** la actualización de Intel si ya está en cola (opcional): usa la herramienta “Show or hide updates” (wushowhide.diagcab), o dime y te paso un script para bloquear un **KB** o un **ID** concreto.

***

## 3) Limpieza **real** del driver anterior (cuando el EXE dice “instalado” pero sigues en 31.x)

### 3.1 Remueve todos los paquetes Intel Display del Driver Store

Usa este script para listar y remover sólo los **INF** Intel de la clase Display:

```powershell
# Enumerar INF de Intel (Display)
$intelInf = Get-CimInstance Win32_PnPSignedDriver |
  Where-Object {
    $_.ClassGuid -eq '{4d36e968-e325-11ce-bfc1-08002be10318}' -and
    ($_.DriverProviderName -match 'Intel' -or $_.Manufacturer -match 'Intel')
  } | Select-Object DeviceName, DriverVersion, DriverDate, InfName

$intelInf | Format-Table

Read-Host "Presiona ENTER para desinstalar todos los INF Intel detectados…"

foreach ($inf in ($intelInf.InfName | Select-Object -Unique)) {
  if ($inf -match '\.inf$') {
    Write-Host "Eliminando $inf…" -ForegroundColor Yellow
    pnputil /delete-driver $inf /uninstall /force
  }
}

Write-Host "Reinicia AHORA. Al volver, instala el Lenovo (n1cdt52w.exe) y valida."
```

> Si `pnputil` te dice que un INF está **en uso**, repite tras reiniciar en **Modo Seguro** (ver 6.1).

***

## 4) Validar **firma y compatibilidad** del paquete Lenovo

A veces falla porque el paquete no coincide con tu build o hay requisitos previos ausentes.

*   **Comprueba firma del EXE**:

```powershell
Get-AuthenticodeSignature "C:\Drivers\n1cdt52w.exe" | Format-List Status, SignerCertificate
```

Debe ser `Status: Valid`.

*   **Comprueba la descompresión**: algunos EXE primero extraen a `C:\Drivers\` y **luego** instalan. Si solo se extrajo, ve a esa carpeta y lanza el `Setup.exe` desde allí.

*   **Pre-requisitos** típicos (normalmente ya están):
    *   .NET Framework 4.8+
    *   Visual C++ Runtimes (x64)
    *   Reinicios pendientes (pendiente de Windows Update)
        ```powershell
        (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue) -ne $null
        ```

***

## 5) Si todo falla: **instalación limpia** (DDU opcional) + **DISM/SFC**

### 5.1 Reparar integridad del sistema (por si hay corrupción)

```powershell
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
```

Reinicia y vuelve a intentar.

### 5.2 Modo Seguro + DDU (opcional, avanzado)

DDU (Display Driver Uninstaller) limpia por completo drivers de video.  
Flujo típico:

1.  **Desconectar internet** (para que Windows no baje drivers).
2.  Entrar a **Modo Seguro**.
3.  Ejecutar DDU → limpiar **Intel**.
4.  Reiniciar normal → **instalar Lenovo**.
5.  Volver a conectar internet.

*(Si quieres, te paso guía paso a paso con DDU.)*

***

## 6) Otras causas frecuentes y sus remedios

### 6.1 Modo Seguro para liberar archivos bloqueados

*   **Shift + Reiniciar** → Solucionar problemas → Opciones avanzadas → Configuración de inicio → Reiniciar → F4 (Modo seguro).
*   Luego ejecuta la **limpieza con pnputil** y reinstala.

### 6.2 **Antivirus**/EDR bloquea instalador

*   Desactiva temporalmente **protección en tiempo real** durante la instalación del driver.
*   Reactívalo al terminar.

### 6.3 **Secure Boot/BitLocker**

*   En algunos equipos, el driver no se activa hasta el próximo arranque “limpio”.
*   Si tienes **BitLocker**, asegúrate de tener la clave a mano por si reinicia con verificación.

### 6.4 **Cambios de BIOS**

*   Asegura que **Switchable Graphics** está **Enabled/Hybrid** (valor por defecto).
*   No fuerces solo NVIDIA; DWM depende de la Intel.

***

## 7) Diagnóstico de error de instalación (si necesitas más detalle)

*   **Logs del instalador (MSI)**:  
    Ejecuta el EXE con logging:
    ```powershell
    Start-Process "C:\Drivers\n1cdt52w.exe" -ArgumentList "/L*V `"%USERPROFILE%\Desktop\intel_setup.log`"" -Wait
    ```
    Luego revisa `intel_setup.log`.

*   **Log del Plug and Play (muy útil)**:
        C:\Windows\INF\setupapi.dev.log
    Búscalo por “igdlh/igfx” para ver por qué rechazó el INF.

***

## 8) Mini‑script para **revalidar** (rápido)

```powershell
$intel = Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "Intel" }
$intel | Select Name, DriverVersion, DriverDate | Format-Table
```

Debe mostrar:

    Intel(R) HD Graphics 530   30.0.100.9865   ~02/21/2022

***

## 9) ¿Quieres que el **script completo** se auto‑recupere si el EXE falla?

Te dejo una **versión robusta** de la función de instalación que:

*   Intenta modo silencioso
*   Si falla, **lanza interactivo**
*   Si aún así no queda, **instala por INF** desde la carpeta extraída
*   Revalida y reinicia si es necesario

```powershell
function Install-IntelFromLenovo {
    param([Parameter(Mandatory=$true)][string]$ExePath, [string]$ExpectedVersion = "30.0.100.9865")

    if (-not (Test-Path $ExePath)) { throw "No existe: $ExePath" }

    Write-Host "Instalando paquete Lenovo: $ExePath" -ForegroundColor Cyan
    $silentArgs = @("/S","/s","/VERYSILENT","/silent")
    $ok = $false
    foreach ($arg in $silentArgs) {
        try {
            $p = Start-Process -FilePath $ExePath -ArgumentList $arg -Wait -PassThru
            if ($p.ExitCode -eq 0) { $ok = $true; break }
        } catch {}
    }
    if (-not $ok) {
        Write-Host "Instalación silenciosa no disponible. Lanzando modo interactivo…" -ForegroundColor Yellow
        Start-Process -FilePath $ExePath
        Read-Host "Completa el asistente y presiona ENTER para continuar…"
    }

    # Intentar detectar carpeta de extracción típica de Lenovo
    $candidateDirs = @(
        "C:\DRIVERS",
        "C:\Drivers",
        "C:\SWTOOLS",
        "C:\Lenovo"
    )
    $infFound = $null
    foreach ($base in $candidateDirs) {
        if (-not (Test-Path $base)) { continue }
        $inf = Get-ChildItem -Path $base -Recurse -Include *.inf -ErrorAction SilentlyContinue |
               Where-Object { $_.Name -match 'ig.*(dlh|fx).*\.inf' } |
               Select-Object -First 1
        if ($inf) { $infFound = $inf.FullName; break }
    }

    if ($infFound) {
        Write-Host "Instalando INF directo: $infFound" -ForegroundColor Cyan
        pnputil /add-driver "$infFound" /install
    } else {
        Write-Host "No se encontró INF de Intel en carpetas Lenovo habituales. Si conoces la ruta del INF, instálalo con pnputil." -ForegroundColor Yellow
    }

    # Verificación
    $intel = Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match "Intel" }
    if ($intel.DriverVersion -ne $ExpectedVersion) {
        Write-Host "La versión aún no coincide ($($intel.DriverVersion) ≠ $ExpectedVersion). Recomiendo REINICIAR y volver a validar." -ForegroundColor Yellow
    } else {
        Write-Host "✔ Driver correcto activo: $ExpectedVersion" -ForegroundColor Green
    }
}
```

Uso:

```powershell
Install-IntelFromLenovo -ExePath "C:\Drivers\n1cdt52w.exe" -ExpectedVersion "30.0.100.9865"
```

***

## ¿Quieres que te integre esta función en tu script “todo‑en‑uno” y lo vuelva a subir con manejo de fallos y ruta INF automática?

Si me confirmas la **ruta exacta** donde el EXE descomprime (te la muestra el asistente al inicio), te lo dejo 100% automatizado para tu T560.
