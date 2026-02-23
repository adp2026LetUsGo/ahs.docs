
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

``` Powershell

Get-CimInstance Win32_VideoController | Select Name,DriverVersion,DriverDate
```