-- Keyword tables used by omni-completion, grouped by configuration section.
local M = {}

M.global = {
  "aaa", "access-list", "archive", "banner", "boot", "class-map", "clock",
  "control-plane", "crypto", "enable", "end", "errdisable", "hostname",
  "interface", "ip", "ipv6", "line", "logging", "login", "mac", "monitor",
  "no", "ntp", "policy-map", "router", "route-map", "service", "snmp-server",
  "spanning-tree", "username", "vlan", "vrf", "vtp", "ip access-list",
  "ip route", "ip domain-name", "ip name-server", "ip ssh", "ip dhcp",
  "service password-encryption", "service timestamps", "no ip domain-lookup",
}

M.interface = {
  "description", "shutdown", "no shutdown", "ip address", "no ip address",
  "ip address dhcp", "ip helper-address", "ip access-group", "ip ospf",
  "ip nat inside", "ip nat outside", "ip proxy-arp", "ipv6 address",
  "ipv6 enable", "duplex", "speed", "mtu", "bandwidth", "vrf forwarding",
  "switchport", "switchport mode access", "switchport mode trunk",
  "switchport access vlan", "switchport trunk allowed vlan",
  "switchport trunk native vlan", "switchport trunk encapsulation dot1q",
  "switchport port-security", "switchport nonegotiate", "channel-group",
  "spanning-tree portfast", "spanning-tree bpduguard enable", "standby",
  "encapsulation dot1Q", "cdp enable", "lldp transmit", "lldp receive",
  "service-policy input", "service-policy output", "tunnel source",
  "tunnel destination", "tunnel mode", "load-interval", "negotiation auto",
}

M.router = {
  "network", "neighbor", "router-id", "passive-interface", "redistribute",
  "default-information originate", "auto-summary", "no auto-summary",
  "area", "maximum-paths", "log-adjacency-changes", "address-family",
  "bgp router-id", "bgp log-neighbor-changes", "timers", "distance",
  "summary-address", "version 2",
}

M.line = {
  "password", "login", "login local", "transport input ssh",
  "transport input none", "exec-timeout", "logging synchronous",
  "access-class", "privilege level", "session-timeout", "length 0",
}

M.acl = { "permit", "deny", "remark", "evaluate", "permit ip any any", "deny ip any any" }

M.route_map = { "match", "set", "continue", "description" }

-- Map section-opening command (first word) to a keyword list.
M.sections = {
  interface = M.interface,
  router = M.router,
  line = M.line,
  ["ip"] = M.acl, -- ip access-list ...
  ["ipv6"] = M.acl,
  ["route-map"] = M.route_map,
  ["vrf"] = { "rd", "address-family", "route-target export", "route-target import", "description" },
  ["class-map"] = { "match", "description" },
  ["policy-map"] = { "class", "description" },
  ["vlan"] = { "name", "state active", "state suspend" },
  ["aaa"] = {},
}

return M
