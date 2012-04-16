#!/bin/sh

set -e
echo "ROC_STATUS: Installing Rails"
export PATH=~/Documents/rails_one_click/ruby/bin:$PATH

gem install rails

exit