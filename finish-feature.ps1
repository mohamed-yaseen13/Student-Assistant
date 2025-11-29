# finish-feature.ps1

# Get the current branch name
$currentBranch = git rev-parse --abbrev-ref HEAD

# Ask for the commit message
$commitMessage = Read-Host "Enter commit message"

# Add all changes
git add .

# Commit
git commit -m "$commitMessage"

# Push current branch to origin
git push -u origin $currentBranch

# Switch to development
git checkout development

# Merge current branch into development
git merge $currentBranch

# Push development branch
git push origin development

Write-Host "✅ Feature branch '$currentBranch' has been merged into 'development' and pushed."
