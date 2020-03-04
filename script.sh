# handles a merge to be passed without conflicts
# forces user to resolve through git ui in vscode
ensure_no_confilicts () {
    temp="$1"
    merge_state=$(git diff --full-index && git diff-index HEAD)
    if [ ! -z "$merge_state" ]
    then
        echo "To continue - please resolve and commit merge conflicts in the GIT panel."
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
        echo "Conflicts resolved"
    else
        echo "No Conflicts to resolve"
    fi
}
git branch -D TEMP
git checkout -b TEMP
message=$(git merge master)
echo "$message"
# ensure_no_confilicts $(git merge master)
# git checkout master
# git merge TEMP
# git push
# git checkout $branch
# echo "Done :)"


# echo "**********************************************************
# This script requieres your master-flasked-debugging branch
# to be up to date and contain the changes you wish to push to master.
# Running it will merge the branch master-flasked-debugging to master
# and push both branches to the remote."
# echo "Once started there are no brakes on the merge train. Are you sure you wish to run it? yes/no"
# read varname
# if [[ "$varname" == "yes" || "$varname" == "y" ]]
# then
#     echo "Please enter branch name to merge (press enter for current branch):"
#     read branch
#     if [ "$branch" == "" ]
#     then branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
#     fi
#     echo "merging $branch to master_flasked_debugging"
#     git checkout master-flasked-debugging
#     ensure_no_confilicts $(git pull)
#     git merge $branch
#     echo "merge successful."
#     echo "pushing changes to master-flasked-debugging remote"
#     git push

#     echo "updating the master branch"
#     git checkout master
#     ensure_no_confilicts $(git pull)
#     echo "clearing possible left overs from previous runs"
#     git branch -D TEMP

#     git checkout -b TEMP
#     ensure_no_confilicts$(git merge master)
#     git checkout master
#     git merge TEMP
#     git push
#     git checkout $branch
#     echo "Done :)"
# else
#     if [[ "$varname" == "no" || "$varname" == "n" ]]
#     then
#         echo "As you wish."
#     else
#         echo "Bad input. Learn to read, punk."
#     fi
# fi