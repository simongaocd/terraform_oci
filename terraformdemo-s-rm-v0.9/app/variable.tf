variable "compartment_ocid" {
    default=""
}
variable "ad_name" {
    default=""
}
variable "vm_shape" {
    default=""
}
variable "image_id" {
    default=""
}
variable "subnet_id" {
    default=""
}
#variable "public_key_path" {}

variable "vm_user"{
    default ="opc"
}


variable "ssh_public_key"{
    default=""
}


#amd
variable "instance_memory"{
    default = "8"
}

variable "instance_ocpus" {
    default = "1"
}
