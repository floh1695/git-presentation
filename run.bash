#!/bin/bash

source code/git.bash
source code/tools.bash

function repo-a
{
  echo '--- REPO_A --- START ---'
 
  git_init
  
  git branch apple
  git branch banana  
  
  git_commit
  
  git checkout apple
  git_commit
  
  git checkout banana
  git_commit
  git tag rebase-banana
  git rebase master
    
  git checkout master
  git merge apple --no-edit
    
  echo '--- REPO_A --- END ---'
}

function merge-simple ()
{
  git_init
  
  git_commit

  git checkout -b apple

}

function mkrepos ()
{
  repo-a
}

repos_dir='repos'

rm -rf $repos_dir
wrapd $repos_dir mkrepos

