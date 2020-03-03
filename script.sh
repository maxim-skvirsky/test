git branch -D TEMP
git checkout -b TEMP
out=$(git merge master)
if [[ $out == CONFLICT* ]]
then
    # echo $out
    echo "Please fix merge conflicts, the script will resume once conflicts are resolved and commited."
    merge_state = $(git diff --full-index)
    while [ ! -z "$merge_state" ]; do
        info = "waiting for conflicts to be resolved ..."
        delay = 1
        spinstr='|/-\'
        temp=${spinstr#?}
        printf "$info [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        local reset="\b\b\b\b\b\b"
        for ((i=1; i<=$(echo $info | wc -c); i++)); do
            reset+="\b"
        done
        printf $reset
        merge_state = $(git diff --full-index)
    done
    printf "    \b\b\b\b"
    echo "Conflicts resolved. Continueing"
else
    echo "all gewd"
fi

echo "DONE"