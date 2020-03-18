#!/bin/bash

{{ ansible_managed|comment }}

set -o nounset
set -o errexit

VTI_IF="vti${PLUTO_MARK_OUT%%/*}"

case "${PLUTO_VERB}" in
    up-client)
        ip tunnel add "${VTI_IF}" mode vti \
                        local "${PLUTO_ME}" remote "${PLUTO_PEER}" \
            okey "${PLUTO_MARK_OUT%%/*}" ikey "${PLUTO_MARK_IN%%/*}"
        ip link set "${VTI_IF}" up
        sysctl -w "net.ipv4.conf.${VTI_IF}.disable_policy=1"

        case "${PLUTO_CONNECTION}" in
            {% for conn in vpn_gateway_vpns.site_to_site %}
            {{ conn.name }})
                {% for route in conn.routes %}
                    ip addr add {{ hetzner_vswitch_host[0].ipv4_address }} remote {{ route.remote_network }} dev "${VTI_IF}"
                {% endfor %}
                    ip route add {{ conn.remote_public_ip }} via {{ vpn_gateway_public_network_gateway }} dev {{ vpn_gateway_ethernet_dev }}
                ;;
            {% endfor %}
        esac
        ;;
    down-client)
        ip tunnel del "${VTI_IF}" || true
        ;;
esac
