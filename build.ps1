
../../jbook_template/Scripts/activate   
Remove-Item -Path _build -Recurse -Force -Confirm:$false
jb clean .
jb build .
start _build/html/intro.html    