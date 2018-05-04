#!/bin/bash

mkdir -p repos

pushd repos
  
  rm -rf repo-a
  mkdir -p repo-a
  
  pushd repo-a    
    git init
    
    git config user.email 'a@fake.com'
    git config user.name 'a'

    git branch apple
    git branch banana
    
    git commit --allow-empty-message
    
    git checkout apple
    git commit --allow-empty-message

    git checkout banana
    git commit --allow-empty-message
    git rebase master

    git checkout master
    git merge apple
  popd
popd

