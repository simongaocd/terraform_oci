resource "oci_identity_compartment" "company" {
  description = "The company compartment"
  name        = "${var.company_tag}_${var.environment}"
}