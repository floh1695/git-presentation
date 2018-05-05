#!/bin/bash

wrapd ()
{
  mkdir -p $1
  pushd $1 > /dev/null
  $2
  popd > /dev/null
}

