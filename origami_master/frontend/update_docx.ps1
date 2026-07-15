$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open("d:\PRM393\Project\Project\origami_master\Origami Master App.docx")
    
    $selection = $word.Selection
    
    # Text replacements
    $FindText = "Private Creations Count"
    $ReplaceText = "Public Creations Count"
    $MatchCase = $false
    $MatchWholeWord = $true
    $MatchWildcards = $false
    $MatchSoundsLike = $false
    $MatchAllWordForms = $false
    $Forward = $true
    $Wrap = 1
    $Format = $false
    $Replace = 2 # wdReplaceAll

    $selection.Find.Execute($FindText, $MatchCase, $MatchWholeWord, $MatchWildcards, $MatchSoundsLike, $MatchAllWordForms, $Forward, $Wrap, $Format, $ReplaceText, $Replace) | Out-Null
    
    # Insert new screens at the end
    $selection.EndKey(6) | Out-Null # wdStory = 6
    $selection.InsertBreak(2) # wdSectionBreakNextPage = 2
    $selection.InsertFile("d:\PRM393\Project\Project\origami_master\updates.html")
    
    $doc.Save()
    Write-Host "Word document updated successfully."
}
catch {
    Write-Host "An error occurred: $_"
}
finally {
    if ($doc) { $doc.Close() }
    $word.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
