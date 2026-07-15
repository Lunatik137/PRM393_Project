$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open("d:\PRM393\Project\Project\origami_master\Origami Master App.docx")
    
    $selection = $word.Selection
    
    # Text replacements
    $FindText = "Updates to Origami Master App"
    $MatchCase = $false
    $MatchWholeWord = $false
    $MatchWildcards = $false
    $MatchSoundsLike = $false
    $MatchAllWordForms = $false
    $Forward = $true
    $Wrap = 1
    $Format = $false

    $selection.Find.Execute($FindText, $MatchCase, $MatchWholeWord, $MatchWildcards, $MatchSoundsLike, $MatchAllWordForms, $Forward, $Wrap, $Format, "", 0) | Out-Null
    
    if ($selection.Find.Found) {
        $start = $selection.Start
        $end = $doc.Content.End
        $range = $doc.Range($start, $end)
        $range.Delete() | Out-Null
        Write-Host "Deleted appended section."
    }
    
    $doc.Save()
}
catch {
    Write-Host "An error occurred: $_"
}
finally {
    if ($doc) { $doc.Close() }
    $word.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
