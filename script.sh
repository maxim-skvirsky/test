ensure_no_confilicts () {
    out="$1"
    if [[ $out == CONFLICT* ]]
    then
        # echo $out
        echo "To continue - please resolve and commit merge conflicts in the GIT panel."
        merge_state=$(git diff --full-index && git diff-index HEAD)
        info="waiting for conflicts to be resolved and commited..."
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
}

git branch -D TEMP
git checkout -b TEMP
ensure_no_confilicts $(git merge master)
