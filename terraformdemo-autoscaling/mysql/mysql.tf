resource "oci_mysql_mysql_db_system" "prod_mysql1" {
    #Required
    admin_password = var.admin_password
    admin_username = var.admin_username
    availability_domain = var.ad_name
    compartment_id = var.compartment_ocid
    shape_name = var.mysql_shape
    subnet_id = var.subnet_id
    display_name ="MySQLInstance1"
    
    data_storage_size_in_gb = var.data_storage_size_in_gb
}
