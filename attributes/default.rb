

default[:softether][:hub][:name] = 'hub1'

default[:softether][:user][:group] = ''
default[:softether][:user][:realname] = ''
default[:softether][:user][:note] = ''

default[:softether][:ipsec][:options][:l2tp] = 'yes'
default[:softether][:ipsec][:options][:l2tprw] = 'yes'
default[:softether][:ipsec][:options][:etherip] = 'yes'
default[:softether][:ipsec][:options][:sharedkey] = 'sharedkey'

default[:softether][:bridge][:devicename] = 'eth0'
