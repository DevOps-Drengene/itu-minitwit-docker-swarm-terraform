#!/bin/bash

# Copy stack file
scp -i ssh_key/terraform stack/minitwit_stack.yml root@$(terraform output minitwit-swarm-leader-ip-address):~
# Copy DB config
scp -i ssh_key/terraform db-config root@$(terraform output minitwit-swarm-leader-ip-address):~
# Load DB config into env vars and update Docker stack
ssh -o 'StrictHostKeyChecking no' -i ssh_key/terraform root@$(terraform output minitwit-swarm-leader-ip-address) "source db-config && docker stack up minitwit -c minitwit_stack.yml"
