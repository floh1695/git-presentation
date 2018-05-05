#!/bin/bash

repos_dir='repos'

next_commit_number=0
function next_commit ()
{
  filename="${next_commit_number}.txt"
  next_commit_number=$(($next_commit_number + 1))

  touch $filename
  git add $filename
  git commit -m "$filename"
}

function git_config ()
{
  git config user.email 'a@fake.com'
  git config user.name 'a'
}

rm -rf $repos_dir
mkdir -p $repos_dir
pushd $repos_dir
  
  mkdir -p repo-a
  
  pushd repo-a    
    echo '--- REPO_A --- START ---'
    
    git init
    git_config

    # Initial commit is required before branching
    next_commit
    
    git branch apple
    git branch banana  
    
    next_commit
    
    git checkout apple
    next_commit
    
    git checkout banana
    next_commit
    git tag rebase-banana
    git rebase master
    
    git checkout master
    git merge apple --no-edit
    
    echo '--- REPO_A --- END ---'
  popd
popd

