#!/bin/bash
unset GIT_DIR
if "$4" == "-b"
then
  git checkout -b "$2"
fi
DIRS="$(find ./$1 -mindepth 1 -maxdepth 5 -type d)"
for d in $DIRS
do
    cd $d
    FILES="$(find . -name '*.png')"
    for f in $FILES
    do
      if "$f" = "database.yml" || "$f" == "Gemfile.lock" || "$f" == "$0"
      then
        echo "skipping $f"
      else
        git add "$f"
      fi
    done
done
git commit -m "$3"
git push origin "$2"
