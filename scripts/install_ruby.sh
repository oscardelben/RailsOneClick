#!/bin/sh

set -e

# TODO: should we install psych?

# Installation path needs to be passed from the command line
target_dir=~/Documents/rails_one_click/ruby

cd /tmp
if [ ! -e ruby-1.9.3-p125 ]
then
  curl -o http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
  tar xzvf ruby-1.9.3-p125.tar.gz
fi
cd ruby-1.9.3-p125
./configure --prefix=$target_dir --disable-install-doc
make && make install
