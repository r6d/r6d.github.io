

watch -n 5 "vtysh -c 'show ip bgp' && vtysh -c 'show ip bgp summary'"

watch -n 30 'vtysh -c "show ip bgp su" && vtysh -c "show ipv6 bgp su"'

watch -n 30 'vtysh -c "show ip route"|grep ^B && vtysh -c "show ipv6 route"|grep ^B'

