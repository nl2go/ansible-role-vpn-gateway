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
            {% for config in vpn_gateway_configs %}
            "{{ config.name }}")
                {% for network in config.remote.networks %}
                    ip addr add {{ config.local.private }} remote {{ network }} dev "${VTI_IF}"
                {% endfor %}
                    ip route add {{ config.remote.public }} via {{ config.local.public }} dev {{ config.local.private_interface }}
                ;;
            {% endfor %}
        esac
        ;;
    down-client)
        ip tunnel del "${VTI_IF}" || true
        ;;
esac
