# Erstelle eine neue Ansible-Rolle
```bash
ansible-galaxy init roles/helpdeskpro_base
```

# Starte das Playbook für die Hostgruppe 'win_dev' mit dem angegebenen Inventory
```bash
ansible-playbook site.yml -i inventory.yaml -l win_dev
```