resource "oci_objectstorage_bucket" "magento_bucket" {
    #Required
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.bucket_namespace
}

resource "oci_objectstorage_object" "magento_basic" {
  bucket     = oci_objectstorage_bucket.magento_bucket.name
  content    = data.template_file.installhttpd.rendered
  namespace  = var.bucket_namespace
  object     = "orm.zip"
}

resource "oci_objectstorage_object" "magento_media" {
  for_each      = fileset("${path.module}/static/", "**")

  bucket        = oci_objectstorage_bucket.magento_bucket.name
  namespace     = var.bucket_namespace
  object        = each.value
  source        = "${path.module}/static/${each.value}"
}

data "template_file" "installhttpd" {
  template = filebase64("${path.module}/scripts/orm.zip")
}