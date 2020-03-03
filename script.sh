git branch -D TEMP
git checkout -b TEMP
out=$(git merge master)
if [[ $out == CONFLICT* ]]
then
    # echo $out
    echo "Please fix merge conflicts, the script will resume once conflicts are resolved and commited."
    merge_state=$(git diff --full-index && git diff-index HEAD)
    info="waiting for conflicts to be resolved ..."
    delay=0.2
    spinstr='|/-\'
    echo $info
    while [ ! -z "$merge_state" ]; do
        tput civis
        temp=${spinstr#?}
        printf "[%c]" "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        reset="\b\b\b"
        # reset="\b\b\b\b\b\b"
        # for ((i=1; i<=$(echo $info | wc -c); i++)); do
        #     reset+="\b"
        # done
        printf $reset
        merge_state=$(git diff --full-index && git diff-index HEAD)
        if [[ -z "$merge_state" ]]; then
            echo "[done]"
        fi
    done
    tput cnorm
    echo ""
    echo "Conflicts resolved. Continuing"
else
    echo "all gewd"
fi

echo "DONE"