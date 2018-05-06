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
    
  echo -e '--- REPO_A --- END ---\n'
}

function merge-simple ()
{
  echo '--- MERGE_SIMPLE --- START ---'
  
  git_init
  
  git branch apple

  git_commit

  git checkout apple
  git_commit

  git checkout master
  git merge apple --no-edit

  echo -e '--- MERGE_SIMPLE --- END ---\n'
}

function rebase-simple ()
{
  echo '--- REBASE_SIMPLE --- START ---'
  
  git_init
  
  git branch apple

  git_commit

  git checkout apple
  git_commit
  git tag rebase-apple
  git rebase master
  
  git checkout master
  git merge apple --no-edit

  echo -e '--- REBASE_SIMPLE --- END ---\n'
}

function merge-complex ()
{
  echo '--- MERGE_COMPLEX --- START ---'
  
  git_init
  
  git branch apple
  git branch banana
  git branch coconut
  git branch date

  git checkout apple
  git_commit

  git checkout banana
  git_commit

  git checkout coconut
  git_commit

  git checkout date
  git_commit

  git checkout master
  git merge apple --no-edit
  git merge banana --no-edit
  git merge coconut --no-edit
  git merge date --no-edit

  echo -e '--- MERGE_COMPLEX --- END ---\n'
}

function rebase-complex ()
{
  echo '--- REBASE_COMPLEX --- START ---'
  
  git_init
  
  git branch apple
  git branch banana
  git branch coconut
  git branch date

  git checkout apple
  git_commit
  git tag rebase-apple

  git checkout banana
  git_commit
  git tag rebase-banana

  git checkout coconut
  git_commit
  git tag rebase-coconut

  git checkout date
  git_commit
  git tag rebase-date
  
  git checkout apple
  git rebase master
 
  git checkout master
  git merge apple --no-edit
  
  git checkout banana
  git rebase master
  
  git checkout master
  git merge banana --no-edit
  
  git checkout coconut
  git rebase master
  
  git checkout master
  git merge coconut --no-edit
  
  git checkout date
  git rebase master

  git checkout master
  git merge date --no-edit

  echo -e '--- REBASE_COMPLEX --- END ---\n'
}

function pull-simple ()
{
  echo '--- PULL_SIMPLE --- START ---'

  local origin='origin.git'
  local repo1='repo1'
  local repo2='repo2'

  mkdir -p $origin
  mkdir -p $repo1
  mkdir -p $repo2

  pushd $origin > /dev/null
    git init --bare
  popd > /dev/null

  pushd $repo1 > /dev/null
    git clone "../$origin" .
    git_config

    git_commit
  popd > /dev/null

  pushd $repo2 > /dev/null
    git clone "../$origin" .
  popd > /dev/null

  echo -e '--- PULL_SIMPLE -- END ---\n'
}

function mkrepos ()
{
  # Testing repo only
  #wrapd 'repo-a' repo-a
  
  # Comparison of merge and rebase
  #wrapd 'merge-simple' merge-simple
  wrapd 'rebase-simple' rebase-simple
  #wrapd 'merge-complex' merge-complex
  #wrapd 'rebase-complex' rebase-complex

  # Replicating pull with fetch and merge
  wrapd 'pull-simple' pull-simple
}

repos_dir='repos'

rm -rf $repos_dir
wrapd $repos_dir mkrepos

