# ========= Deactivate any active conda environment =========
conda deactivate



# ========= CONFIGURATION =========
$work_dir = "D:\SANDBOX\Jupyterbooks\nnsa\nnsa"
$venv_dir = "D:\SANDBOX\Jupyterbooks\jbook_template"
$my_book = "nnsa"
$repoUrl = "https://github.com/ocrobotix/$my_book.git"





# ========= Activate Jupyter Book Environment =========
& "$venv_dir\Scripts\Activate.ps1"

# ========= Change to Working Directory =========
Set-Location $work_dir

# ========= Create GitHub Repository (if it doesn't exist) =========
Write-Host "`n📦 Creating GitHub repo '$my_book'..."
gh repo create "ocrobotix/$my_book" --public --source . --push 2>$null

# ========= Force-reset Git Remote =========
if (git remote get-url origin 2>$null) {
    git remote remove origin
    Write-Host "❌ Removed existing remote 'origin'."
}
git remote add origin $repoUrl
Write-Host "🔗 Added remote 'origin': $repoUrl"

# ========= Set Git Config to Suppress CRLF Warnings =========
git config --global core.autocrlf true

# ========= Build Jupyter Book =========
Write-Host "`n⚙ Building Jupyter Book..."
jb clean .
jb build .

# ========= Commit and Push Source =========
git add .
try {
    git commit -m "Source commit"
} catch {
    Write-Host "ℹ Nothing to commit, working tree clean."
}
git push -u origin main

# ========= Publish to GitHub Pages =========
Write-Host "`n🌍 Publishing to GitHub Pages..."
python -m ghp_import -n -p -f _build/html

# ========= Done =========
Write-Host "`n✅ Jupyter Book '$my_book' successfully built and published!"
Write-Host "🌐 View it live at: https://ocrobotix.github.io/$my_book"
