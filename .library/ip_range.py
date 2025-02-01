#!/usr/bin/env python3
# -*- coding: utf-8 -*-

DOCUMENTATION = '''
---
module: cidr_to_ip_list
short_description: Convert CIDR notation to a list of IP addresses
description:
  - This module accepts a CIDR subnet as input and returns a list of all IP addresses in that subnet.
options:
  subnet:
    description:
      - The CIDR subnet (e.g., "192.168.1.0/24") from which to generate IP addresses.
    required: true
    type: str
author:
  - Joe
'''

EXAMPLES = '''
- name: Generate IP list from subnet
  cidr_to_ip_list:
    subnet: "192.168.1.0/24"
  register: result

- name: Show the list of IP addresses
  debug:
    var: result.ip_list
'''

RETURN = '''
ip_list:
  description: List of IP addresses in the given subnet.
  returned: always
  type: list
  sample: ["192.168.1.0", "192.168.1.1", "..."]
'''

from ansible.module_utils.basic import AnsibleModule
import ipaddress

def main():
    module = AnsibleModule(
        argument_spec=dict(
            subnet=dict(type='str', required=True)
        ),
        supports_check_mode=True
    )
    
    subnet = module.params['subnet']
    
    try:
        network = ipaddress.ip_network(subnet, strict=False)
    except ValueError as e:
        module.fail_json(msg="Invalid subnet provided: %s" % str(e))
    
    ip_list = [str(ip) for ip in network]
    
    module.exit_json(changed=False, ip_list=ip_list)

if __name__ == '__main__':
    main()
