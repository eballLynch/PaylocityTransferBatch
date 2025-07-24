# Paylocity File Transfer Script
#### This batch script automates the process of transferring a specific text file **__abpay.txt__** to a destination folder and simultaneously creating a timestamped backup. It includes checks for file existence and size constraints before proceeding with the copy operation.
---
# Features
+ __File Existence Check:__ Verifies if the source file exists before attempting any operations.
+ __File Size Validation:__ Checks if the source file's size falls within a specified range (300-400 KB).
+ __User Confirmation:__ Prompts the user for confirmation if the file size is outside the acceptable range, allowing them to continue or cancel.
+ __Timestamped Copies:__ Creates unique timestamped copies of the file in both the destination and backup folders.
+ __Error Handling:__ Provides basic error messages if file copying fails.
+ __Clear Output:__ Informs the user about the success of the transfer, the destination paths, and the file size.

# Usage
1. __Save the script:__ Save the provided code as a .bat file (e.g., transfer_paylocity_file.bat).
2. __Configure Paths:__ Before running, you must modify the sourceFile, destFolder, and backupFolder variables within the script to reflect your local file paths.
3. __Run the script:__ Double-click the .bat file to execute it.
This script will:
* Check for the source file
* Display its size and warn you if it's outside the specified range.
* Prompt for user input if a warning is issued.
* Copy the file to the destination and backup folders with a timestamp.
* Display the final destination and backup paths.

# Configuration
The following variables, path, and file name need to be adjusted in the script to match your environment. Current path and file name is for testing purposes.
  * `sourceFile`
  * `destFolder`
  * `backupFolder`
    Example:
```
 ::--- MODIFY TO REFLECT PROPER LOCATIONS (set to local file paths for testing)
set "sourceFile=C:\Users\username\Desktop\Paylocity\sourceFile\ABPayTEST4.txt"
set "destFolder=C:\Users\username\Desktop\Paylocity\destFolder"
set "backupFolder=C:\Users\username\Desktop\Paylocity\backupFolder"
```
The script also has a configurable file size range. As of July 23, 2025, the acceptable range is 300-400KB. You can modify these values if needed. 
    Example:
```
:: --- MODIFY TO FIT CURRENT ENVIRONMENT PARAMETERS (300-400KB as of 7/23/2025)
REM Check file size constraints
if %fileSizeKB% LSS 300 (
    echo WARNING: File size ^(%fileSizeKB% KB^) is under 300 KB minimum requirement.
    echo.
    goto :askContinue
)
if %fileSizeKB% GTR 400 (
    echo WARNING: File size ^(%fileSizeKB% KB^) exceeds 400 KB maximum limit.
    echo.
    goto :askContinue
)
```
# Error Handling
The script will display error messages and pause if:
* The `sourceFile` does not exist.
* Copying to the `destFolder` fails.
* Copy to the `backupFolder` fails.

In case of an error, review the displayed message and ensure the paths are correct and you have the necessary permissions to read and write to the specified directories
