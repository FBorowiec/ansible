# `ansible`

Repo I use to set up my work environment from scratch.

## Installing

```bash
./install
```

## Testing

```bash
❯ ./test/test-install-dockerized -h
Usage: ./test/test-install-dockerized [-i|--interactive] [-o|--os ubuntu|arch|both]
  -i, --interactive    Start interactive container
  -o, --os OS         Choose OS to test (ubuntu, arch, or both) [default: both]
```

## Linting

```bash
./test/ansible-lint
```
