variable "admin_password"{}
variable "admin_username" {}
variable "ad_name" {
    default = ""
}
variable "compartment_ocid"{
    default =""
}
variable "mysql_shape" {
    default = ""
}
variable "subnet_id" {
    default = ""
}

variable "data_storage_size_in_gb"{
    default = "50"
}