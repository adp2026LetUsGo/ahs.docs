# Define the source directory and output file
$sourcePath = "C:\Users\armando\Documents\_AHS\ahs.docs\01. 🍀AHS.SaaS\00. AHSCellForge\2. CFAB CellForge Atomic Blueprint\Xinfer"
$outputFile = Join-Path $sourcePath "_Combined_Blueprint.md"

# Get all .md files, excluding the output file if it already exists
$mdFiles = Get-ChildItem -Path $sourcePath -Filter *.md | Where-Object { $_.FullName -ne $outputFile }

$fileData = @()

foreach ($file in $mdFiles) {
    # Read content and find the first H1 header for sorting
    $content = Get-Content -Path $file.FullName -Raw
    $titleLine = ($content -split "`r?`n" | Where-Object { $_ -match "^#\s+(.+)" } | Select-Object -First 1)
    
    # Clean the title (remove the #) or fallback to filename if no header found
    $cleanTitle = if ($titleLine) { $titleLine -replace "^#\s+", "" } else { $file.BaseName }

    $fileData += [PSCustomObject]@{
        Title   = $cleanTitle
        Content = $content
        Path    = $file.FullName
    }
}

# Sort by Title and export to the new file
$fileData | Sort-Object Title | ForEach-Object {
    "---" | Out-File -FilePath $outputFile -Append -Encoding utf8
    "Source: $($_.Path)" | Out-File -FilePath $outputFile -Append -Encoding utf8
    "" | Out-File -FilePath $outputFile -Append -Encoding utf8
    $_.Content | Out-File -FilePath $outputFile -Append -Encoding utf8
    "`n" | Out-File -FilePath $outputFile -Append -Encoding utf8
}

Write-Host "Success: $outputFile has been created." -ForegroundColor Green