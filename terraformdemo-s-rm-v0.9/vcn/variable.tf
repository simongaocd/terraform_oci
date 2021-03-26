variable "compartment_ocid" {}

variable "vcn_cidr_block" {
    default = "172.16.0.0/16"
}

variable "pub_sub_cidr" {
    default = "172.16.1.0/24"
}

variable "priv_sub_cidr" {
    default = "172.16.2.0/24"
}

variable "vcn_display_name" {
    default = "prod_vcn"
}