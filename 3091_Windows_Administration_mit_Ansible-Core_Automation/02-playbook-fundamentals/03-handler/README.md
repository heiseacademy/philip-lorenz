# Führe für alle Tags aus:
```bash
ansible-playbook -i ./inventory.yaml base_setup_handlers.yml -l win_dev 

--tags baseline,compliance,maintenance
```