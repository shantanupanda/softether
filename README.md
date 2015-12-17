SoftEther VPN Cookbook
=====================
SoftEther VPN Project develops and distributes SoftEther VPN, an Open-Source Free ​Cross-platform Multi-protocol VPN Program, as an academic project from University of Tsukuba.

Project Site https://www.softether.org

This cookbook will setup all the components needed to have your own SoftEther VPN Server.

Attributes
----------
#### ethersoftvpn::default


Usage
-----
#### ethersoftvpn::default
Installs all of the dependencies for all EtherSoft Applications.

e.g.
Just include `ethersoftvpn` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[softether]"
  ]
}```



#### ethersoftvpn::server
Installs the server tools and libraries.

e.g.
Just include `ethersoftvpn::server` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[softether::server]"
  ]
}```


License and Authors
-------------------
Authors:Shantanu Panda
