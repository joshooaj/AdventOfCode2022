[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]
    $Path
)



$inventory = Import-ElfSnackInventory -Path $Path

[pscustomobject]@{
    Day       = "Day01"
    Challenge = "Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?"
    Answer    = $inventory.Statistics.Sum | Sort-Object -Descending | Select-Object -First 1
}

[pscustomobject]@{
    Day       = "Day01"
    Challenge = "Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?"
    Answer    = ($inventory.Statistics.Sum | Sort-Object -Descending | Select-Object -First 3 | Measure-Object -Sum).Sum
}