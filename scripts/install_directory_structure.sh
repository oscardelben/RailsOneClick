#!/bin/sh

set -e


target_dir=~/Documents/rails_one_click

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d $target_dir ]
then
  mkdir $target_dir
  cp -r $script_dir/../templates/* $target_dir
fi

exit