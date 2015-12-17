#
#Cookbook: Softether
#Recipe : user
#

node.default['citadel']['bucket'] = 'buscket'

admin_pass = JSON.parse(citadel["keys/softetherpasswords.json"])

c_user = `/usr/local/vpnserver/vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /adminhub:#{node[:softether][:hub][:name]} /cmd UserList | grep 'User Name' | sed 's/|//g' | awk {'print $3'}`.split("\n")

puts c_user.inspect

user_records = JSON.parse(citadel["keys/users.json"])
user_records.each do |record|
username =  record['user']
pw = record['password']
realname = record['realname']

  bash 'UserCreate' do
    user 'root'
    cwd '/usr/local/vpnserver'
    code "echo UserCreate #{username} /GROUP:#{node[:softether][:user][:group]} /REALNAME:#{realname} /NOTE:#{node[:softether][:user][:note]} >> user.txt"
    not_if { c_user.include?("#{username}") }
  end

  bash 'UserPassword' do
    user 'root'
    cwd '/usr/local/vpnserver'
    command "echo UserPasswordSet #{username} /PASSWORD:#{pw} >> user.txt"
  end

  execute 'created user list' do
    user 'root'
    cwd '/usr/local/vpnserver'
    command "echo #{username} >> /tmp/createduserslist.txt"
  end

end

execute 'UserCreate batch' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /adminhub:#{node[:softether][:hub][:name]} /in:user.txt"
end

c_user.each do |user|
  bash 'UserDelete list' do
    user 'root'
    cwd '/usr/local/vpnserver'
    code "echo UserDelete #{user} >> userdel.txt"
    not_if { ::File.readlines('/tmp/createduserslist.txt').grep(/#{user}/).any? }		
  end
end

execute 'UserDelete batch' do
user 'root'
cwd '/usr/local/vpnserver'
command "exec ./vpncmd /server #{node[:ipaddress]} /password:#{admin_pass["adminpassword"]} /adminhub:#{node[:softether][:hub][:name]} /in:userdel.txt"
end

execute 'delete files' do
  user 'root'
  cwd '/tmp'
  command "rm -rf user.txt userdel.txt /tmp/createduserslist.txt"
end
