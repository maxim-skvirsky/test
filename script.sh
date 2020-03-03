git branch -D TEMP
git checkout -b TEMP
out=$(git merge master)
if [[ $out == CONFLICT*]]
then 
    echo "conflict"
else
    echo "all gewd"
fi