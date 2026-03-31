# Baseline ausführen
```bash
ansible-playbook -i ./inventory.yaml ./base_setup_tags.yml -l win_dev --tags baseline
```

# Compliance-Tasks ausführen
```bash
ansible-playbook -i ./inventory.yaml ./base_setup_tags.yml -l win_dev --tags compliance
```

# Compliance im Check-Modus (Trockenlauf)
```bash
ansible-playbook -i ./inventory.yaml ./base_setup_tags.yml -l win_dev --tags compliance --check
```