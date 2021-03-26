variable "compartment_ocid" {}
variable "ad_name" {}
variable "vm_shape" {}
variable "image_id" {}
variable "subnet_id" {}
#variable "public_key_path" {}

variable "vm_user"{
    default ="opc"
}

variable "ssh_private_key"{
    
}

variable "ssh_public_key"{
    
}


#amd
variable "instance_memory"{
    default = "8"
}

variable "instance_ocpus" {
    default = "1"
}
