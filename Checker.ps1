# Define the directory to store the ps1 files
$directory = "C:\PowerShellCmdlets"

# Create the directory if it doesn't exist
if (-Not (Test-Path $directory)) {
    New-Item -Path $directory -ItemType Directory
}

# Get all cmdlets
$cmdlets = Get-Command -CommandType Cmdlet

foreach ($cmdlet in $cmdlets) {
    # Get the name of the cmdlet
    $cmdletName = $cmdlet.Name
    
    try {
        # Create a file name for the cmdlet
        $fileName = Join-Path $directory "$cmdletName.ps1"
        
        # Write the start calc command and the cmdlet name as a comment to the ps1 file
        $content = "start calc`r`n# Cmdlet: $cmdletName`r`n"
        Set-Content -Path $fileName -Value $content
    } catch {
        Write-Host "Failed to create file for cmdlet: $cmdletName" -ForegroundColor Red
    }
}

# Function to iterate through the folder and launch each .ps1 file
function Invoke-Scripts {
    $scriptFiles = Get-ChildItem -Path $directory -Filter *.ps1

    foreach ($scriptFile in $scriptFiles) {
        Write-Host "Running script: $($scriptFile.FullName)"
        try {
            # Start the .ps1 script
            $process = Start-Process powershell.exe -ArgumentList "-File `"$($scriptFile.FullName)`"" -PassThru
            
            # Wait for the Calculator to launch
            Start-Sleep -Seconds 2
            
            # Attempt to close the Calculator process
            for ($i = 0; $i -lt 5; $i++) {
                $calcProcess = Get-Process -Name ApplicationFrameHost -ErrorAction SilentlyContinue | Where-Object {$_.MainWindowTitle -eq "Calculator"}
                if ($calcProcess) {
                    Stop-Process -Id $calcProcess.Id -Force
                    Write-Host "Calculator closed."
                    break
                } else {
                    Write-Host "Calculator not found, retrying..."
                    Start-Sleep -Seconds 1
                }
            }
        } catch {
            Write-Host "Failed to run script: $($scriptFile.FullName)" -ForegroundColor Red
        }
    }
}

# Invoke the function to run the scripts
Invoke-Scripts

Write-Host "All cmdlet scripts have been executed."
