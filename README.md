# PowerShell Cmdlets Detection Script

This repository contains a PowerShell script that creates individual `.ps1` files for each PowerShell cmdlet, executes these scripts, and monitors which cmdlets are detected by a script info detect event in the CS console. The script helps in identifying cmdlets that are recognized during the event.

## Usage

### Prerequisites

- A Windows machine with PowerShell
- Administrator privileges to execute scripts

### Script Overview

The script performs the following tasks:
1. **Create Directory**: Creates a directory to store the `.ps1` files.
2. **Generate Scripts**: Creates individual `.ps1` files for each PowerShell cmdlet, containing a command to start the Calculator and a comment with the cmdlet name.
3. **Execute Scripts**: Iterates through the generated scripts, executes each one, and attempts to close the Calculator.
4. **Monitor Detection**: Monitors which cmdlets are detected by a script info detect event in the CS console.
