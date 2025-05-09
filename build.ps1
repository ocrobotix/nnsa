
../../jbook_template/Scripts/activate   
#rm -Force _build
Remove-Item -Path _build -Recurse -Force -Confirm:$false
jb clean .
jb build .
start _build/html/intro.html    