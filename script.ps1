param (
    [Parameter(Mandatory, HelpMessage="Email associated to the pluralsight account")][string]$username,
    [Parameter(Mandatory, HelpMessage="Password validation")][string]$password,
    [Parameter(HelpMessage="Path to Youtube-dl executable file")][string]$path = ".\youtube-dl.exe",
    [Parameter(HelpMessage="Text file that contains the URL of each course you want to download")][string]$courses = "courses.txt",
    [Parameter(HelpMessage="Text file to save the downloaded courses list")][string]$output = "downloaded-courses",
    [Parameter(HelpMessage="Number of tries to download for every course. If the argument given is 0, it'll perform the operation in an infinite loop until it's done.")][int]$try = 0,
    [Parameter(HelpMessage="Sleep time to download each file in seconds. Valid range starts from 1.")][ValidateRange(1, [int]::MaxValue)][int]$sleep = 120
 )
if( !(Test-Path ".\$($courses)" -PathType Leaf) ){
    Write-Output "the $($courses) text file doesn't exists"
} else {
    $file = Get-Content ".\$($courses)"
    
    if ( !(New-Item -Path . -Name ".\$($output).txt" -ItemType "file") ){
        Clear-Content ".\$($output).txt"
    }

    foreach($course in $file) {
        $i = $try
        $downloaded = $false
        do {
            if($i -ne $try) {
                for($timer = $sleep; $timer -ge 0; $timer--) {
                    Write-Host "`rwait for $($timer) seconds..." -NoNewline
                    Start-Sleep -Seconds 1
                }
            }
            & $PathToExecutable --username $($username) --password $($password) "$($course)" --verbose --no-check-certificate --all-subs --sleep-interval $($sleep) -o "./%(playlist)s - pluralsight/%(chapter_number)s-%(chapter)s/%(autonumber)03d-%(title)s.%(ext)s" --playlist-start 1 --add-header Referer:"https://app.pluralsight.com/library/courses/"
            if ( ($?) -and ($LASTEXITCODE -eq 0) ) {
                $downloaded = $true
                break
            }

            Write-Output "failed to download from $($course)"
        } while(--$i -ne 0)
        
        if($downloaded) {
	        $file | Where{$_ -ne $course } | Out-File ".\$($courses)" -Force
    	    Add-Content -Path ".\$($output).txt" -Value $course
        } else {
            exit 1
        }
    }
}