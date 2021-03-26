
resource "oci_core_instance_configuration" "instanceconfiguration" {
  compartment_id = var.compartment_ocid
  display_name   = var.instance_configuration_name

  instance_details {
    instance_type = "compute"

    launch_details {
      #compartment_id = var.compartment_ocid
      shape          = var.vm_shape
      display_name   = var.instance_configuration_name

      create_vnic_details {
        assign_public_ip       = "true"
      }

      metadata = {
        ssh_authorized_keys = var.ssh_public_key
        #user_data           = base64encode(var.user-data)
      }

      source_details {
        source_type = "image"
        image_id    = var.image_id
      }
    }
  }
}

resource "oci_core_instance_pool" "instancepool" {
  compartment_id            = var.compartment_ocid
  instance_configuration_id = oci_core_instance_configuration.instanceconfiguration.id
  size                      = 1
  state                     = "RUNNING"
  display_name              = "InstancePool"

  placement_configurations {
    availability_domain = var.ad_name
    primary_subnet_id   = var.subnet_id
  }

  load_balancers {
        #Required
        backend_set_name = var.lbend_set_name
        load_balancer_id = var.lbalancer_id
        port = var.lb_pool_port
        vnic_selection = "PrimaryVnic"
   }
}

resource "oci_autoscaling_auto_scaling_configuration" "autoscalingconfiguration" {
  compartment_id       = var.compartment_ocid

  auto_scaling_resources {
    id   = oci_core_instance_pool.instancepool.id
    type = "instancePool"
  }

  cool_down_in_seconds = "300"
  display_name         = "AutoScalingConfiguration"
  is_enabled           = "true"

  policies {
    capacity {
      initial = "1"
      max     = "4"
      min     = "1"
    }

    display_name = "autoscaling"
    policy_type  = "threshold"

    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = "1"
      }

      display_name = "ScaleOutRule"

      metric {
        metric_type = "CPU_UTILIZATION"

        threshold {
          operator = "GT"
          value    = "50"
        }
      }
    }

    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = "-1"
      }

      display_name = "ScaleInRule"

      metric {
        metric_type = "CPU_UTILIZATION"

        threshold {
          operator = "LT"
          value    = "40"
        }
      }
    }
  }
}

