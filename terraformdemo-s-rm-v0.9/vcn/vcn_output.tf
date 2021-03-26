output "vcnid" {
  value = oci_core_vcn.prod_vcn.id
}

output "app_subnet_id" {
  value = oci_core_subnet.app-public-subnet.id
}

output "db_subnet_id"{
  value = oci_core_subnet.db-private-subnet.id
}