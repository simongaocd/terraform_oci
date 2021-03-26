variable "compartment_ocid" {
    default = ""
}
variable "ad_name" {
    default = ""
}
variable "vm_shape" {
    default = ""
}
variable "image_id" {
    default = ""
}
variable "subnet_id" {
    default = ""
}

#variable "public_key_path" {}

variable "vm_user"{
    default ="opc"
}

variable "ssh_private_key"{
    default = ""
}

variable "ssh_public_key"{
    default = ""
}

variable "num_nodes" {
    default = "1"
}

#amd
variable "instance_memory"{
    default = "8"
}

variable "instance_ocpus" {
    default = "1"
}

variable "boot_volume_size_in_gbs"{
    default = "200"
}

# amd Shapes
locals {
  compute_flexible_shapes = ["VM.Standard.E3.Flex"]
}