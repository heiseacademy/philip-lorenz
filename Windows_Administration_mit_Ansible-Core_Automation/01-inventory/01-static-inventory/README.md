# Run Ping Check yaml:
```bash
ansible -i hosts.yaml windows -m ansible.windows.win_ping
```

# Run Ping Check ini:
```bash
ansible -i hosts.ini domain_controllers -m ansible.windows.win_ping
```