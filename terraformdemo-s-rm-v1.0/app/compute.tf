
locals {
  httpd_script        = "~/install_httpd.sh"
}

#get script file path
data "template_file" "installhttpd" {
  template = file("${path.module}/scripts/installhttpd.sh")
}

resource "oci_core_instance" "app_instance" {
    # Required
    availability_domain = var.ad_name
    compartment_id = var.compartment_ocid
    shape = var.vm_shape

    count = var.num_nodes

    source_details {
        source_id = var.image_id
        source_type = "image"
        # 
        boot_volume_size_in_gbs = var.boot_volume_size_in_gbs

    }

    dynamic "shape_config" {
     for_each = local.is_flexible_instance_shape ? [1] : []
     content {
        #for e3
        memory_in_gbs = var.instance_memory
        ocpus = var.instance_ocpus
     }
    }

    # Optional
    display_name = "manento_app_${count.index}"

    create_vnic_details {
        assign_public_ip = true
        subnet_id = var.subnet_id
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
        user_data           = base64encode(data.template_file.installhttpd.rendered)
    } 
    preserve_boot_volume = false
}

locals {
  is_flexible_instance_shape = contains(local.compute_flexible_shapes, var.vm_shape)
}

