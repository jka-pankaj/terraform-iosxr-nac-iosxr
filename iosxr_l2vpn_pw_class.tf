resource "iosxr_l2vpn_pw_class" "l2vpn_pw_class" {
  for_each = {
    for item in flatten([
      for device_name, device in { for d in local.devices : d.name => d } : [
        for pw_class_name, pw_class in try(local.device_config[device.name].l2vpn_pw_classes, {}) : {
          device_key = device.name
          name       = pw_class_name
          config     = pw_class
        }
      ]
    ]) : "${item.device_key}:${item.name}" => item
  }

  device = each.value.device_key
  name   = each.value.name

  delete_mode = try(each.value.config.delete_mode, null)

  # MPLS Encapsulation
  encapsulation_mpls = try(each.value.config.encapsulation_mpls, null)

  # Transport Mode Settings
  encapsulation_mpls_transport_mode_ethernet    = try(each.value.config.encapsulation_mpls_transport_mode_ethernet, null)
  encapsulation_mpls_transport_mode_vlan        = try(each.value.config.encapsulation_mpls_transport_mode_vlan, null)
  encapsulation_mpls_transport_mode_passthrough = try(each.value.config.encapsulation_mpls_transport_mode_passthrough, null)

  # Load Balancing Settings
  encapsulation_mpls_load_balancing_pw_label = try(each.value.config.encapsulation_mpls_load_balancing_pw_label, null)

  # Flow Label Settings - Both
  encapsulation_mpls_load_balancing_flow_label_both        = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_both, null)
  encapsulation_mpls_load_balancing_flow_label_both_static = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_both_static, null)

  # Flow Label Settings - Receive
  encapsulation_mpls_load_balancing_flow_label_receive        = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_receive, null)
  encapsulation_mpls_load_balancing_flow_label_receive_static = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_receive_static, null)

  # Flow Label Settings - Transmit
  encapsulation_mpls_load_balancing_flow_label_transmit        = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_transmit, null)
  encapsulation_mpls_load_balancing_flow_label_transmit_static = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_transmit_static, null)

  # Flow Label Code Settings
  encapsulation_mpls_load_balancing_flow_label_code_one7         = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_code_one7, null)
  encapsulation_mpls_load_balancing_flow_label_code_one7_disable = try(each.value.config.encapsulation_mpls_load_balancing_flow_label_code_one7_disable, null)
}
