resource "tls_private_key" "public_private_key_pair" {
  algorithm = "RSA"
}

module "a_vcn" {
  source           = "./vcn"

  compartment_ocid = var.compartment_ocid
  vcn_display_name = "${var.company_tag}_vcn"
  vcn_cidr_block   = var.vcn_cidr
  pub_sub_cidr     = var.pub_sub_cidr
  priv_sub_cidr    = var.priv_sub_cidr
}

#single compute instance

module "app_compute" {
    source   = "./app"

    compartment_ocid = var.compartment_ocid
    ad_name          = data.oci_identity_availability_domains.ads.availability_domains[0].name
    vm_shape         = var.vm_shape
    instance_ocpus   = var.instance_ocpus
    instance_memory  = var.instance_memory
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
    image_id         = var.image_id
    subnet_id        = module.a_vcn.app_subnet_id
    ssh_public_key   = file(var.ssh_public_key)
    ssh_private_key  = file(var.ssh_private_key)

    #instance count
    num_nodes = var.num_nodes
}



module "lb" {
    source   = "./lb"

    compartment_ocid = var.compartment_ocid
    subnet_id        = module.a_vcn.app_subnet_id
    private_ip       = module.app_compute.private_ip
    
    #instance count
    num_nodes = var.num_nodes
}

module "mds_instance" {
    source         = "./mysql"

    admin_password       = var.admin_password
    admin_username       = var.admin_username
    ad_name              = data.oci_identity_availability_domains.ads.availability_domains[0].name
    mysql_shape          = var.mysql_shape
    compartment_ocid     = var.compartment_ocid
    subnet_id            = module.a_vcn.db_subnet_id
  
}

module "os" {
  source           = "./objectstorage"
  compartment_id   = var.compartment_ocid
  bucket_name      = "prod"
  bucket_namespace = data.oci_objectstorage_namespace.user_namespace.namespace
}


#get MySQL Database Service configurations
data "oci_mysql_mysql_configurations" "shape" {
    compartment_id = var.compartment_ocid
    type = ["DEFAULT"]
    shape_name = var.mysql_shape
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

# Gets ObjectStorage namespace
data "oci_objectstorage_namespace" "user_namespace" {
  compartment_id = var.compartment_ocid
}


# Output ads result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# Output app public id
output "app-publicip"{
    value = module.app_compute.public_ip
}


#Output load balancer ip

output "loadbalancer-ip"{
    value = module.lb.public_ip
}
#Output mysql id
output "mysql-ip"{
    value = module.mds_instance.private_ip
}

