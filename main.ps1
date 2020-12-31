Import-Module .\tests\tests.psm1

$DateJson = Get-Content .\files\commitDate.json | ConvertFrom-Json
$CurrentDate = "02-28-2021"
# Get-Date -Format "MM-dd-yyyy"
function GetLastCommit {
    $LastCommit = Get-Content -Path ".\files\commits.txt" -Tail 1
    [int]$CommitNumber = $LastCommit -replace "[a-z\s\:]"
    return $CommitNumber
}

function ReturnJsonValue {
    if ($DateJson -match $CurrentDate)
    { return $DateJson.$CurrentDate }
    else {
        Write-Host "Nothing to do today"
        Start-Sleep 5
        break
    }       
}

function MakeCommit {
    param (
        [int]$TimesOfCommit
    )
    $CommitNumber = GetLastCommit
    Write-Host "Pushing the commits to remote repository.`n"
    for ($i = 1; $i -le $TimesOfCommit; $i++) {
        git add .
        git commit -m "commit number: $($CommitNumber)" | Out-Null
        git push origin main | Out-Null
        Clear-Host
        start-sleep 2
        Write-Host "Commit Number: $($CommitNumber)`n"
        Add-Content -Path "./files/commits.txt" -Value "Commit Number: $($CommitNumber +1)" 
        $CommitNumber++
    }
}

function CheckJsonValueAndCommit {
    $JsonValue = ReturnJsonValue
    if ($JsonValue -eq "special") {
        MakeCommit -TimesOfCommit 15
    }
    elseif ($JsonValue -eq "normal") {
        MakeCommit -TimesOfCommit 5
    }
    Write-Host "All done for today`nClosing the script"
    Start-Sleep 5
}

function DoTests {
    try {
        Test-GitInstalled
        Test-GitUserAndEmail
        Test-GitRepository
        Test-GitRemote
        Test-GitPull
        Test-FileAndDirectory
        Test-JsonIntegrity
        Test-GetLastCommit
    }
    catch {
        Write-Host "Something goes wrong, Check the source code to find the problem.`n"
        CloseScript "Press any key to close"
        break
    }

}
function Main {
    DoTests
    Write-Host "All tests done! continuing"
    CheckJsonValueAndCommit
}

Main