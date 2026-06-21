```bash
ansible-playbook -i inventory.ini demo.yml
ansible-playbook -i inventory.ini demo.yml
```

Der zweite Lauf liest die Facts aus `.fact-cache` statt sie erneut vom Zielsystem zu sammeln (siehe `ansible.cfg`).
