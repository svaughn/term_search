# Install-Module -Name Selenium -RequiredVersion 1.2

param (
    [string]$search_item_file_name = '.\IIB_Commands.txt'
)

$dataSet = @()

$Driver = Start-SeChrome

Get-Content $search_item_file_name | `
    ForEach-Object {
        $term = $_.trim()
        $search_url = "https://www.google.com/search?q=`"$term`""
    
        Enter-SeUrl -Driver $Driver -Url $search_url

	Wait-SeElementExists -Driver $Driver -Id 'result-stats' -Timeout 6000

        [string] $result_stats = (Find-SeElement -Driver $Driver -Id 'result-stats').text
        [int] $count = $result_stats.split(" ")[1] -replace ",",""

        $row = [pscustomobject]@{
            term = $term
            count =  $count
        }

        $dataSet += $row
    }

Stop-SeDriver  -Driver $Driver  

$count_sum = ($dataSet | Measure-Object "count" -Sum).Sum

$dataSet = $dataSet | Sort-Object -Property count -Descending

$dataSet | ForEach-Object {
    $row = $_
    $relative = $row.count / $count_sum
    $row | Add-Member -MemberType NoteProperty -Name relative -Value $relative
}

$csv_file_name = "$search_item_file_name.csv"

$dataSet | Export-Csv -Path $csv_file_name -Encoding ASCII -NoTypeInformation