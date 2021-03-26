output "public_ip"{
    value = oci_core_instance.app_instance.public_ip
}

output "private_ip"{
    value = oci_core_instance.app_instance.private_ip
}