#
#Cookbook : Softhether
#Recipe: config
#

node.default['citadel']['bucket'] = 'bucket'

admin_pass = JSON.parse(citadel["keys/softetherpasswords.json"])

execute 'softethervpn password set' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password: /cmd ServerPasswordSet #{admin_pass["adminpassword"]}"
end

execute 'hub create' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /cmd HubCreate #{node[:softether][:hub][:name]} /password:#{admin_pass["hubpassword"]}"
end

execute 'Bridge Create' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /cmd BridgeCreate #{node[:softether][:hub][:name]} /DEVICE:#{node[:softether][:bridge][:devicename]} /TAP:yes"
end

execute 'Set hub' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /cmd Hub #{node[:softether][:hub][:name]}"
end

execute 'Enable Secure Nat' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /adminhub:#{node[:softether][:hub][:name]} /cmd SecureNatEnable"
end

execute 'IPSECEnable' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /cmd IPsecEnable /L2TP:#{node[:softether][:ipsec][:options][:l2tp]} /L2TPRAW:#{node[:softether][:ipsec][:options][:l2tprw]} /ETHERIP:#{node[:softether][:ipsec][:options][:etherip]} /PSK:#{node[:softether][:ipsec][:options][:sharedkey]} /DEFAULTHUB:#{node[:softether][:hub][:name]}"
end
