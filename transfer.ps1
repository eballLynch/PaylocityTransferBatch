# ABPAY File Transfer Script with Size Validation
# Source file path
$sourceFile = "C:\Users\eball\Desktop\Code\Paylocity\sourceFile\ABPay.txt"

# Check if source file exists
if (-not (Test-Path $sourceFile)) {
    Write-Host "Error: Source file not found at $sourceFile" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Get file size in KB
$fileSize = (Get-Item $sourceFile).Length / 1KB
$fileSizeRounded = [Math]::Round($fileSize, 2)

Write-Host "Source File: $sourceFile" -ForegroundColor Cyan
Write-Host "File size: $fileSizeRounded KB" -ForegroundColor Yellow

# Check file size constraints
if ($fileSize -gt 400) {
    Write-Host "WARNING: File size ($fileSizeRounded KB) is over 400 KB!" -ForegroundColor Red
    $sizeAlert = $true
} elseif ($fileSize -lt 300) {
    Write-Host "WARNING: File size ($fileSizeRounded KB) is under 300 KB!" -ForegroundColor Red
    $sizeAlert = $true
} else {
    Write-Host "File size is within acceptable range (300-400 KB)" -ForegroundColor Green
    $sizeAlert = $false
}

# If there's a size alert, require Y key to continue
if ($sizeAlert) {
    do {
        Write-Host "`nFile size is outside acceptable range. Do you want to continue? (Press Y to continue, any other key to exit): " -NoNewline -ForegroundColor Yellow
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Write-Host $key.Character
        
        if ($key.Character -eq 'Y' -or $key.Character -eq 'y') {
            Write-Host "Continuing with process..." -ForegroundColor Green
            break
        } else {
            Write-Host "Process cancelled by user." -ForegroundColor Red
            Write-Host "Press any key to exit..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            exit 0
        }
    } while ($true)
}

# Generate timestamp for filename
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Destination paths
$paylocityDest = "C:\Users\eball\Desktop\Code\Paylocity\destFolder"
$tcmBackupDest = "C:\Users\eball\Desktop\Code\Paylocity\backupFolder"

try {
    # Copy to Paylocity folder
    Write-Host "`nCopying file to Paylocity folder..." -ForegroundColor Green
    Copy-Item $sourceFile $paylocityDest -ErrorAction Stop
    Write-Host "Successfully copied to: $paylocityDest" -ForegroundColor Green
    
    # Copy to TCM backup location
    Write-Host "Creating backup copy..." -ForegroundColor Green
    Copy-Item $sourceFile $tcmBackupDest -ErrorAction Stop
    Write-Host "Successfully created backup: $tcmBackupDest" -ForegroundColor Green
    
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "The TCM file ABPAY has been transferred to the Paylocity folder" -ForegroundColor Green
    
} catch {
    Write-Host "Error during file copy: $($_.Exception.Message)" -ForegroundColor Red
}

# Pause equivalent
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")