output "public_ip" {
  value = [oci_load_balancer_load_balancer.lb1.ip_address_details]
}