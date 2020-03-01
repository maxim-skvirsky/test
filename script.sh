git branch -D TEMP
git checkout -b TEMP
out=$(git merge master)
echo "out $out"