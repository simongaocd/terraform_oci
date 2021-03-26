
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "nat-gw"
  vcn_id         = oci_core_vcn.prod_vcn.id 

}

resource "oci_core_route_table" "nat_route" {
  compartment_id = var.compartment_ocid
  display_name   = "private-route-table"

  route_rules {
    destination       = local.anywhere
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }

  vcn_id = oci_core_vcn.prod_vcn.id
}