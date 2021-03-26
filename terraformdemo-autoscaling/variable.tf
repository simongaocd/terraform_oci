#account info
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}

#app variable
variable "company_tag" {
    default = "demo"
}

variable "environment" {
    default = "test"
}


variable "vcn_cidr" {
  default = "172.16.0.0/16"
}

variable "pub_sub_cidr" {
    default = "172.16.1.0/24"
}

variable "priv_sub_cidr" {
    default = "172.16.2.0/24"
}

#compute

variable "vm_shape"{
   #default = "VM.Standard2.1"
   default = "VM.Standard.E3.Flex"
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

variable "num_nodes"{
    default ="1"
}

variable "ssh_private_key"{
    default ="/Users/jianbing/id_rsa"
}

variable "ssh_public_key"{
    default = "/Users/jianbing/id_rsa.pub"
}


variable "image_id" {
    default = "ocid1.image.oc1.ap-sydney-1.aaaaaaaa3fkl2evlr2j4uxsctjzd3i5b62sytm6wntjtvtql76r73pqj2bfa"
}



#mysql configuration
variable "admin_password" {
    default="MyMagentoPassw0rd]"
}

variable "admin_username" {
    default = "admin"
}

variable "mysql_shape" {
    default = "MySQL.VM.Standard.E3.1.8GB"
}

variable "data_storage_size_in_gb"{
    default = "100"
}




