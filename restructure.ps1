Set-Location "d:\Coding\ChaiLoveKaapi"

New-Item -ItemType Directory -Force -Path "menu", "story", "franchise" | Out-Null

$filesToMove = @("menu.html", "story.html", "franchise.html")
foreach ($f in $filesToMove) {
    if (Test-Path $f) {
        Move-Item -Path $f -Destination "$($f.Split('.')[0])/index.html" -Force
    }
}

# Root index
if (Test-Path "index.html") {
    $content = Get-Content "index.html" -Raw
    $content = $content -replace 'href="index\.html"','href="./"' -replace 'href="menu\.html"','href="menu/"' -replace 'href="story\.html"','href="story/"' -replace 'href="franchise\.html"','href="franchise/"'
    Set-Content "index.html" -Value $content -Encoding UTF8
}

# Nested files
$targets = @(
    @{"File"="menu/index.html"; "Self"="menu"},
    @{"File"="story/index.html"; "Self"="story"},
    @{"File"="franchise/index.html"; "Self"="franchise"}
)

foreach ($t in $targets) {
    $f = $t.File
    $self = $t.Self
    if (Test-Path $f) {
        $content = Get-Content $f -Raw
        $content = $content -replace 'href="index\.html"','href="../"'
        $content = $content -replace 'href="menu\.html"','href="../menu/"'
        $content = $content -replace 'href="story\.html"','href="../story/"'
        $content = $content -replace 'href="franchise\.html"','href="../franchise/"'
        
        # Optimize self-reference:
        $content = $content -replace "href=`"\.\./$self/`"","href=`"./`""
        
        $content = $content -replace 'href="css/','href="../css/'
        $content = $content -replace 'src="js/','src="../js/'
        $content = $content -replace 'src="images/','src="../images/'
        $content = $content -replace 'data-img="images/','data-img="../images/'
        
        Set-Content $f -Value $content -Encoding UTF8
    }
}
