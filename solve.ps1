[CmdletBinding()]
param(
    [Parameter()]
    [int[]]
    $Day,

    [Parameter()]
    [switch]
    $UseSampleInput
)

$location = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($location)) {
    $location = (Get-Location).Path
}

Get-ChildItem -Path $location\Functions\*.ps1 | ForEach-Object {
    try {
        . $_.FullName
    } catch {
        throw
    }
}

$puzzleInput = if ($UseSampleInput) { 'puzzle-input-sample.txt' } else { 'puzzle-input.txt' }
Get-ChildItem -Path $location\Day* -Directory | Sort-Object Name -PipelineVariable directory | ForEach-Object {
    if ($directory.Name -notmatch 'Day(?<num>\d+)') {
        throw "Directory does not match expected format: $($directory.Name)"
    }
    if ($Day.Count -ne 0 -and ([int]$Matches.num -notin $Day)) {
        Write-Verbose "Day $($directory.Name) not selected"
        return
    }
    $puzzle = Join-Path $directory.FullName 'solve.ps1'
    $puzzleInput = Join-Path $directory.FullName $puzzleInput
    Write-Verbose "Solving puzzle for $($directory.Name)"
    .$puzzle -Path $puzzleInput
}