

Write-Host "--- Starting Impacket Examples Bulk Build ---"
Write-Host "Searching for .py files in the current directory..."

$ImpacketTools = Get-ChildItem -Path "." -Filter "*.py" | Where-Object { 
    $_.Name -notmatch "__init__.py" -and
    $_.Name -notmatch "setup.py"
}


foreach ($Tool in $ImpacketTools) {
    $ToolName = $Tool.BaseName     # psexec.py -> psexec
    $ToolPath = $Tool.FullName     # psexec.py
    
    Write-Host "`nBuilding tool: $($ToolName).exe ..."
    
    
    pyinstaller --onefile $ToolPath --name $ToolName --hidden-import impacket -y
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "PyInstaller failed for $ToolPath. Continuing with next tool."
    }
}

Write-Host "`n--- Build Complete! ---"
Write-Host "All standalone binaries (.exe) are located in the 'dist' folder."