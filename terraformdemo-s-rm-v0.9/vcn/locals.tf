locals {
  all_protocols       = "all"
  anywhere            = "0.0.0.0/0"
  source_network_cidr = var.pub_sub_cidr
  ssh_port            = 22
  web_port            = 80
  mysql_port          = 3306
  mysql_xportmin      = 33060
  mysql_xportmax      = 33061
  tcp_protocol        = 6
}