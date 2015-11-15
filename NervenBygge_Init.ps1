# Initializes Nerven Bygge into current directory

$bygge_url = "https://www.nuget.org/api/v2/package/Nerven.Bygge"
$solution_file = "$(Resolve-Path("."))\$((Get-Item ".").Name).sln"
$temp_name = "__NervenBygge"
$temp_file = $temp_name + ".zip"
$temp_dir = $temp_name

Write "Bygge URL: $bygge_url"
Write "Solution File: $solution_file"

Write "Downloading ..."
$httpclient = New-Object System.Net.WebClient
$httpclient.DownloadFile($bygge_url, $temp_file)

Write "Creating temp directory ..."
New-Item -ItemType Directory -Path $temp_dir | Out-Null

Write "Extracting downloaded archive into temp directory ..."
$shell_app = New-Object -com shell.application
$temp_file_shell = $shell_app.namespace("$(Convert-Path($temp_file))")
$temp_dir_shell = $shell_app.namespace("$(Convert-Path($temp_dir))")
$temp_dir_shell.CopyHere($temp_file_shell.items())

Write "Deleting downloaded archive ..."
Remove-Item $temp_file

$bygge_dir = (Get-Item "__NervenBygge\build").FullName
$bygge_cmd = "$bygge_dir\bygge.reset.cmd"

Write "Command: $bygge_cmd"

Write "Performing initialization ..."
$env:NERVENSOLUTIONFILE = $solution_file
Start-Process -Wait -PassThru -NoNewWindow -FilePath $bygge_cmd -WorkingDirectory $bygge_dir

Write "Deleting temp directory ..."
Remove-Item -Recurse $temp_dir

Write "Done."
