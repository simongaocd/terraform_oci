resource "oci_load_balancer_load_balancer" "lb1" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [var.subnet_id]

  display_name = "magento lb1"
}

resource "oci_load_balancer_backend_set" "set1" {
  name             = "set1"
  load_balancer_id = oci_load_balancer_load_balancer.lb1.id
  policy           = "IP_HASH"

  health_checker {
    port                = "80"
    protocol            = "TCP"
    #response_body_regex = ".*"
    #return_code         = "200"
    #url_path            = "/"
    interval_ms         = 5000
    timeout_in_millis   = 2000
    retries             = 10
  }
}

resource "oci_load_balancer_listener" "listener1" {
  load_balancer_id         = oci_load_balancer_load_balancer.lb1.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.set1.name
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_backend" "be1" {
  load_balancer_id = oci_load_balancer_load_balancer.lb1.id
  backendset_name  = oci_load_balancer_backend_set.set1.name
  ip_address       = element(var.private_ip, count.index)
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1

  count = var.num_nodes
}