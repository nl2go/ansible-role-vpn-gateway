[![Travis (.org) branch](https://img.shields.io/travis/nl2go/ansible-role-vpn-gateway/master)](https://travis-ci.org/nl2go/ansible-role-vpn-gateway)
[![Ansible Galaxy](https://img.shields.io/badge/role-nl2go.vpn-gateway-blue.svg)](https://galaxy.ansible.com/nl2go/vpn_gateway/)
[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/nl2go/ansible-role-vpn-gateway)](https://galaxy.ansible.com/nl2go/vpn_gateway)
[![Ansible Galaxy Downloads](https://img.shields.io/ansible/role/d/46005.svg?color=blue)](https://galaxy.ansible.com/nl2go/vpn_gateway/)

# Ansible Role: VPN Gateway

An Ansible Role that manages a VPN tunnel setup between two peers based on [IPsec](https://de.wikipedia.org/wiki/IPsec) / [strongSwan](https://www.strongswan.org/) 
and provides gateway related routing configuration.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    vpn_gateway_configs:
      - name: default
        psk: secret
        
Configuration sets must be defined using `vpn_gateway_configs` variable. The `name` of the configuration set is mandatory and
used for identification. Pre-shared key can be specified using `psk`.
    
    vpn_gateway_configs:
      - name: default
        psk: secret
        local:
          public: 1.1.1.1
          private: 172.4.0.20
          private_interface: eth6
          networks:
            - 172.4.0.0/21
        remote:
          public: 1.2.3.4
          networks:
            - 172.240.0.0/21
            - 10.2.0.0/16

A configuration set contains the `local` and `remote` peer configuration part.

    vpn_gateway_config_dir: "/etc/ipsec.d/{{ role_name }}"
    
Defines the custom IPsec configuration directory for isolation purposes.

## Tags

Tags can be used to limit the role execution to a particular task module. Following tags are available:

- `vpn_gateway`: Covers the full role lifecycle.
- `vpn_gateway_install`, `install`: Installs required packages
- `vpn_gateway_config`, `config`: Configures required packages

## Dependencies

None.

## Example Playbook

    - hosts: all
      roles:
         - nl2go.vpn_gateway
              
## Development
Use [docker-molecule](https://github.com/nl2go/docker-molecule) following the instructions to run [Molecule](https://molecule.readthedocs.io/en/stable/)
or install [Molecule](https://molecule.readthedocs.io/en/stable/) locally (not recommended, version conflicts might appear).

Provide Hetzner Cloud token:

    export HCLOUD_TOKEN=123abc456efg

Use following to run tests:

    molecule test --all

## Maintainers

- [build-failure](https://github.com/build-failure)
- [pablo2go](https://github.com/pablo2go)

## License

See the [LICENSE.md](LICENSE.md) file for details.

## Author Information

This role was created by in 2020 by [Newsletter2Go GmbH](https://www.newsletter2go.com/).
