#
# Cookbook Name:: softether
# Recipe:: default
#

include_recipe      'apt'
include_recipe      'build-essential'

# install all the dependencies {curl,gcc,binutils,tar,gzip,glibc,zlib,openssl,readline,ncurses,pthread}.

package ['curl','gcc','libc6-dev','make','openssl','binutils','zlibc','libreadline6',' ibreadline6-dev'] do 
action :install
end
