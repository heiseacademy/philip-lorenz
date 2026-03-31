mkdir -p group_vars/win_dev
ansible-vault create group_vars/win_dev/vault.yml

ansible-playbook good_license_encrypted.yml -i inventory.yaml -l win_dev --ask-vault-pass

ansible-vault edit group_vars/win_dev/vault.yml

