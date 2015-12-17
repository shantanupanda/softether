#
# Cookbook Name:: softethervpn
# Recipe:: server
#

include_recipe      'apt'
include_recipe      'build-essential'
include_recipe      'curl'

include_recipe      'softether::default'


install_directory ="/usr/local"
download_url = "http://www.softether-download.com/files/softether/v4.06-9437-beta-2014.04.09-tree/Linux/SoftEther%20VPN%20Server/64bit%20-%20Intel%20x64%20or%20AMD64/softether-vpnserver-v4.06-9437-beta-2014.04.09-linux-x64-64bit.tar.gz"

remote_file "/tmp/softether-vpnserver-v4.06-9437-beta-2014.04.09-linux-x64-64bit.tar.gz" do
    source download_url
    mode "0755"
    action :create
end

bash 'unpack_ethersoft_vpn' do
  user 'root'
  cwd install_directory
  code <<-EOH
   tar -zxvf /tmp/softether-vpnserver-v4.06-9437-beta-2014.04.09-linux-x64-64bit.tar.gz
  EOH
end

bash 'Install SoftEther' do
user 'root'
cwd '/usr/local/vpnserver'
code <<-EOH
ranlib lib/libcharset.a
ranlib lib/libcrypto.a
ranlib lib/libedit.a
ranlib lib/libiconv.a
ranlib lib/libintelaes.a
ranlib lib/libncurses.a
ranlib lib/libssl.a
ranlib lib/libz.a
ranlib code/vpnserver.a
gcc code/vpnserver.a -O2 -fsigned-char -pthread -m64 -lm -ldl -lrt -lpthread -L./ lib/libssl.a lib/libcrypto.a lib/libiconv.a lib/libcharset.a lib/libedit.a lib/libncurses.a lib/libz.a lib/libintelaes.a -o vpnserver
ranlib code/vpncmd.a
gcc code/vpncmd.a -O2 -fsigned-char -pthread -m64 -lm -ldl -lrt -lpthread -L./ lib/libssl.a lib/libcrypto.a lib/libiconv.a lib/libcharset.a lib/libedit.a lib/libncurses.a lib/libz.a lib/libintelaes.a -o vpncmd
./vpnserver start
EOH
end

cookbook_file '/etc/init.d/vpnserver' do
  source 'vpnserver.txt'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


directory "/var/lock/subsys" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
  not_if { ::File.directory?("//var//lock//subsys") }
end

