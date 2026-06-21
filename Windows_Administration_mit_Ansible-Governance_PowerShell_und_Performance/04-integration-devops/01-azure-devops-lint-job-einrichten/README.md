Lokaler Lint-Check:

```bash
ansible-lint demo.yml
```

`pipeline.yml` richtet denselben Check als Azure DevOps Pipeline-Job ein (Trigger auf `main`, `ubuntu-latest`-Pool).
