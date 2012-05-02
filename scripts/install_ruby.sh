#!/bin/sh

set -e

# TODO: should we install psych?

# Installation path needs to be passed from the command line
target_dir=~/Documents/rails_one_click/ruby

# install yaml support

cd /tmp
if [ ! -e yaml-0.1.4 ]
then
  echo "ROC_STATUS: Downloading libyaml"
  curl -O http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
  tar xzvf yaml-0.1.4.tar.gz
fi

echo "ROC_STATUS: Installing libyaml"
cd yaml-0.1.4
./configure --prefix=$target_dir
make && make install

# install ruby

cd ../

if [ ! -e ruby-1.9.3-p194 ]
then
  echo "ROC_STATUS: Downloading Ruby"
  curl -O http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
  tar xzvf ruby-1.9.3-p194.tar.gz
fi
echo "ROC_STATUS: Installing Ruby"
cd ruby-1.9.3-p194
./configure --prefix=$target_dir --disable-install-doc --enable-shared --enable-pthread --with-libyaml-dir=$target_dir --enable-load-relative
make && make install

exit