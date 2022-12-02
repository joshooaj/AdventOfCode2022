function Import-ElfSnackInventory {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Path
    )

    process {
        $elves = [system.collections.generic.list[pscustomobject]]::new()
        $elf = $null
        Get-Content $Path -PipelineVariable line | ForEach-Object {
            if ([string]::IsNullOrWhiteSpace($line)) {
                if ($null -ne $elf) {
                    $elf.Statistics = $elf.Inventory | Measure-Object -Sum -Minimum -Maximum -Average
                    $elves.Add($elf)
                    $elf = $null
                }
            } else {
                if ($null -eq $elf) {
                    $elf = [pscustomobject]@{
                        Inventory = [system.collections.generic.list[int]]::new()
                        Statistics = $null
                    }
                }
                $elf.Inventory.Add([int]$line.Trim())
            }
        }
        if ($null -ne $elf) {
            $elf.Statistics = $elf.Inventory | Measure-Object -Sum -Minimum -Maximum -Average
            $elves.Add($elf)
            $elf = $null
        }
        $elves
    }
}