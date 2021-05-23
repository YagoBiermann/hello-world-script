function Test-GetLastCommit {
    $LastCommit = Get-Content -Path ".\files\commits.txt" -Tail 1
    if ($null -eq $LastCommit) {
        Write-Output "File empty! Writing the firts line..."
        Add-Content -Path ".\files\commits.txt" -Value "Initial commit number: 0"
    }
    elseif ($LastCommit -match '\:*[a-z]$') {
        Write-Output "Commit numbers are broken, you can fix them by manually modifying commits that have strings after the colon`n"
        CloseScript "Press any key to close"
        break
    }
}

function Test-FileAndDirectory {
    $TestCommitFile = Test-Path -path ".\files\commits.txt" -PathType leaf
    $TestFilesDirectory = Test-Path -Path ".\files"
    $TestJsonFile = Test-Path -path ".\files\commitDate.json" -PathType leaf
    if (!($TestFilesDirectory)) {
        Write-Host "Directory 'files' not found`nCreating directory..."
        New-Item -Path "./files/" -ItemType Directory | Out-Null
        New-Item -Path "./files/commits.txt" -ItemType File | Out-Null
    }
    elseif (!($TestCommitFile)) {
        Write-Host "Some files not found`nCreating them..."
        New-Item -Path "./files/commits.txt" -ItemType File | Out-Null
    }
    elseif (!($TestJsonFile)) {
        Write-Host "JSON file with commit and dates not found! impossible to continue..."
        CloseScript "Press any key to close"
        break
    }
}

function Test-GitPull {
    $GitPull = git pull
    if ($GitPull -notmatch "Already up to date.") {
        Write-Host "Git Pull failed, check it manually.`n"
        CloseScript "Press any key to close"
        break
    }
}

function Test-GitInstalled {
    try {
        git | Clear-Host
    }
    catch {
        Write-Output "Git not found, please make sure that you have git installed`n"
        CloseScript "Press any key to close"
        break
    }
}

function Test-GitRepository {
    $GitRepository = Test-Path -Path '.git'
    if (!($GitRepository)) {
        Write-Host "The script do not found a git repository in the current path`n"
        CloseScript "Press any key to close"
        break
    }    
}

function Test-GitUserAndEmail {
    $GitUser = $(git config --global user.name)
    $GitEmail = $(git config --global user.email)
    if (($GitUser -or $GitEmail) -eq "") {
        Write-Host "You must set your username and email before making the commit`ngit config --global user.name 'YourUserName'`ngit config --global user.email 'YourEmail'`n"
        CloseScript "Press any key to close"
        break
    }
}

function Test-GitRemote {
    $GitRemoteURL = $(git config remote.origin.url)
    if ("" -eq $GitRemoteURL) {
        Write-Host "You must set the remote repository for the script`nTry 'git remote add origin 'git@github.com:YourUsername:PathToRepository.git''`n"
        CloseScript "Press any key to close"
        break
    }
}

function Test-JsonIntegrity {
    $DateJson = Get-Content .\files\commitDate.json | ConvertFrom-Json
    $ResponseForNotValidJSON = "Json file invalid!`nThe file must follow the pattern { 'mm-dd-yyyy' :'special' or 'normal }'"
    if ($null -eq $DateJson) {
        Write-Host $ResponseForNotValidJSON
        CloseScript "Press any key to close"
        break
    }
    elseif ($DateJson.psobject.Properties.value -notcontains "special" -or $DateJson.psobject.Properties.value -notcontains "normal") {
        Write-Host $ResponseForNotValidJSON
        CloseScript "Press any key to close"
        break
    }
    $DateJson.psobject.Properties.name | ForEach-Object -Process { if ($_ -notmatch '^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[0-1])[- /.](19|20)\d\d$') {
        Write-Host "The date $($_) is wrong! fix it manually in commitDate.json"
        CloseScript "Press any key to close"
        break
        } }
}

function CloseScript ($message) {
    Write-Host "$message" -ForegroundColor Yellow
    $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}