
variable "compartment_ocid" {
    default =""
}


variable "ssh_public_key" {
    default = ""
}

variable "vm_shape" {
  default = "VM.Standard.E3.Flex"
}

#amd
variable "instance_memory"{
    default = "8"
}

variable "instance_ocpus" {
    default = "1"
}

variable "instance_configuration_name" {
    default ="magento instance config"
}


variable "image_id" {
    default =""
}

variable "ad_name" {
    default =""
}

variable "subnet_id" {
    default =""
}

variable "lbend_set_name" {
    default =""
}

variable "lbalancer_id" {
    default =""
}

variable "lb_pool_port" {
    default ="80"
}



