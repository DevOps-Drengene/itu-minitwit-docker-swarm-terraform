#!/bin/bash

template_file='scripts/load_balancer_template.conf'
output_file='temp/load_balancer.conf'

rm $output_file &>/dev/null
cp $template_file $output_file

rows=$(terraform output minitwit-swarm-leader-ip-address)
rows+=' '
rows+=$(terraform output -json minitwit-swarm-manager-ip-address | jq -r .[])
rows+=' '
rows+=$(terraform output -json minitwit-swarm-worker-ip-address | jq -r .[])

for ip in $rows; do
    # For macOS
    gsed -i "/upstream backend {/a server $ip:3000;" $output_file
    # For Linux
    # sed -i "/upstream backend {/a server $ip:8080;" $output_file
done
