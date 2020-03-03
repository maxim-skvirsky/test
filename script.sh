git branch -D TEMP
git checkout -b TEMP
out=$(git merge master)
if [[ $out == CONFLICT* ]]
then
    # printf $out
    printf "Please fix merge conflicts, the script will resume once conflicts are resolved and commited."
    merge_state=$(git diff --full-index)
    while [ ! -z "$merge_state" ]; do
        info="waiting for conflicts to be resolved ..."
        delay=1
        spinstr='|/-\'
        temp=${spinstr#?}
        printf "$info [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        reset="\b\b\b\b\b\b"
        for ((i=1; i<=$(printf $info | wc -c); i++)); do
            reset+="\b"
        done
        printf $reset
        merge_state=$(git diff --full-index)
    done
    printf "    \b\b\b\b"
    printf "Conflicts resolved. Continueing"
else
    printf "all gewd"
fi

printf "DONE"