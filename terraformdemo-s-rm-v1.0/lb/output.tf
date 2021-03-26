output "public_ip" {
  value = [oci_load_balancer_load_balancer.lb1.ip_address_details]
}

output "lbend_set_name"{
  value = oci_load_balancer_backend_set.set1.name
}

output "lbalancer_id"{
  value = oci_load_balancer_load_balancer.lb1.id
}