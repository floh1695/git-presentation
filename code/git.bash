#!/bin/bash

next_commit_number=0
function git_commit ()
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

function git_init ()
{
  git init
  git_config
  git_commit # Required to allow branching
}

