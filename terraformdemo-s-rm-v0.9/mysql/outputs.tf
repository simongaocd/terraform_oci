
output "private_ip" {
  value = oci_mysql_mysql_db_system.prod_mysql1.ip_address
}
