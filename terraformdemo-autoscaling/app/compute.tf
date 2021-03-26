
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
    source_details {
        source_id = var.image_id
        source_type = "image"
        # 
        #boot_volume_size_in_gbs = var.instance_source_details_boot_volume_size_in_gbs

    }

    shape_config {

        #Optional
        memory_in_gbs = var.instance_memory
        ocpus = var.instance_ocpus
    }

    # Optional
    display_name = "app_01"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = var.subnet_id
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    } 
    preserve_boot_volume = false

    #copy and exec scripts
    provisioner "file" {
    content     = data.template_file.installhttpd.rendered
    destination = local.httpd_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key
    }
  }

  provisioner "remote-exec" {
    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
   
    inline = [
       "chmod +x ${local.httpd_script}",
       "sudo ${local.httpd_script}",
    ]
   }
}


