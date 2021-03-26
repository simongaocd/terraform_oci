
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "nat-gw"
  vcn_id         = oci_core_vcn.prod_vcn.id 

}

resource "oci_core_service_gateway" "m_service_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "magent-service-gateway"
  vcn_id         = oci_core_vcn.prod_vcn.id 

  services {
    service_id = lookup(data.oci_core_services.all_services.services[0], "id")
  }
}



resource "oci_core_route_table" "nat_route" {
  compartment_id = var.compartment_ocid
  display_name   = "private-route-table"

  route_rules {
    destination       = local.anywhere
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }

  route_rules {
      destination       = lookup(data.oci_core_services.all_services.services[0], "cidr_block")
      destination_type  = "SERVICE_CIDR_BLOCK"
      network_entity_id = oci_core_service_gateway.m_service_gateway.id
    
  }
  
  vcn_id = oci_core_vcn.prod_vcn.id
}

# Available Services
data "oci_core_services" "all_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}