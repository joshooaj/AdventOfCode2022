Describe "Verify Day 1 Answers" {
    BeforeAll {
        Get-ChildItem -Path .\Functions\*.ps1 | ForEach-Object {
            try {
                . $_.FullName
            } catch {
                throw
            }
        }
    }

    It 'Solves sample input correctly' {
        $results = .\Day01\solve.ps1 -Path .\Day01\puzzle-input-sample.txt
        $results.Count | Should -Be 2
        $results[0].Answer | Should -Be 24000
        $results[1].Answer | Should -Be 45000
    }
}