resource "oci_core_internet_gateway" "ig01" {
  compartment_id = var.compartment_ocid
  display_name   = "ig01"
  vcn_id         = oci_core_vcn.prod_vcn.id
}

resource "oci_core_route_table" "ig_route" {
  compartment_id = var.compartment_ocid
  display_name   = "public-route-table"

  route_rules {
    destination       = local.anywhere
    network_entity_id = oci_core_internet_gateway.ig01.id
  }

  vcn_id = oci_core_vcn.prod_vcn.id
}