
function Generate-ExplorerHTML {
    param(
        $path = "./",
        $ext = ("*.mp3","*.wav"),
        $outfile = "index.html"
    )
    $filePath = Get-ChildItem $PSScriptRoot -Depth 100 -File -Include $ext | % { (Resolve-Path -Relative $_.FullName) -replace "\\","/" }

    $html_template = @"
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nex-Proto</title>
</head>
<body>
    <h1>Download link</h1>
    <div id="app">
        $(
            ($filePath | % { "<li><a href=`"$($_)`" download=`"$(Split-Path $_ -Leaf)`">$($_)</a></li>" }) -join "`n`t`t"
        )
    </div>
</body>
</html>
"@
    $html_template > $outfile
}