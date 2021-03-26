resource "oci_core_vcn" "prod_vcn" {
    #Required
    compartment_id = var.compartment_ocid

    #Optional
    cidr_blocks = [var.vcn_cidr_block]
    display_name = var.vcn_display_name
    dns_label = "magentovcn"
  
}

resource "oci_core_subnet" "app-public-subnet" {

  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.prod_vcn.id 
  cidr_block          = var.pub_sub_cidr
  
  display_name        = "app_public_Subnet"
  dns_label           = "magentopub"
  security_list_ids   = [oci_core_security_list.app-security-list.id]
  route_table_id      = oci_core_route_table.ig_route.id
}

resource "oci_core_security_list" "app-security-list" {
  compartment_id = var.compartment_ocid
  display_name   = "app-security-list"
  vcn_id         = oci_core_vcn.prod_vcn.id 

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # allow ssh
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }

  ingress_security_rules {
    # app port
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.web_port
      max = local.web_port
    }
  }

  ingress_security_rules {
    # app port
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.https_port
      max = local.https_port
    }
  }
}


resource "oci_core_subnet" "db-private-subnet" {

  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.prod_vcn.id 
  cidr_block          = var.priv_sub_cidr
  
  display_name        = "db_private_Subnet"
  dns_label           = "magentopri"
  prohibit_public_ip_on_vnic = "true"

  security_list_ids   = [oci_core_security_list.db-security-list.id]
  route_table_id      = oci_core_route_table.nat_route.id
}


resource "oci_core_security_list" "db-security-list" {
  compartment_id = var.compartment_ocid
  display_name   = "db-security-list"
  vcn_id         = oci_core_vcn.prod_vcn.id 

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # allow ssh
    protocol = local.tcp_protocol
    source   = local.source_network_cidr

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }

  ingress_security_rules {
    # app port
    protocol = local.tcp_protocol
    source   = local.source_network_cidr

    tcp_options {
      min = local.mysql_port
      max = local.mysql_port
    }
  }

  ingress_security_rules {
    # app port
    protocol = local.tcp_protocol
    source   = local.source_network_cidr

    tcp_options {
      min = local.mysql_xportmin
      max = local.mysql_xportmax
    }
  }
}

