# Ansible Collection - manish_psys.nginx

An Ansible collection containing an nginx role with SSL support and comprehensive testing using Molecule.

## Features

- Install and configure Nginx
- SSL certificate generation (self-signed)
- Firewall configuration
- Multiple testing scenarios with Molecule
- Support for CentOS Stream 10

## Requirements

- Python 3.8+
- Podman (for testing)
- Git

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd nginx
   ```

2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

3. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```

4. **Run tests:**
   ```bash
   cd roles/nginx
   molecule test
   ```

## Virtual Environment

This project uses a Python virtual environment to isolate dependencies. The `setup.sh` script will:

- Create a virtual environment in `venv/`
- Install all required Python packages
- Install required Ansible collections

To manually activate the virtual environment:
```bash
source venv/bin/activate
```

To deactivate:
```bash
deactivate
```

## Testing

The project includes comprehensive testing using Molecule with three scenarios:

### Default Scenario
Basic nginx installation with default SSL configuration.
```bash
cd roles/nginx
molecule test --scenario-name default
```

### HTTP-Only Scenario
Nginx configuration without SSL.
```bash
cd roles/nginx
molecule test --scenario-name http-only
```

### Custom SSL Scenario
Nginx with custom SSL organization details.
```bash
cd roles/nginx
molecule test --scenario-name custom-ssl
```

## Role Variables

### Default Variables (roles/nginx/defaults/main.yml)

| Variable | Default | Description |
|----------|---------|-------------|
| `nginx_ssl_enabled` | `true` | Enable/disable SSL |
| `nginx_http_port` | `80` | HTTP port |
| `nginx_https_port` | `443` | HTTPS port |
| `nginx_ssl_org` | `"Example Organization"` | SSL certificate organization |
| `nginx_ssl_ou` | `"IT Department"` | SSL certificate organizational unit |
| `nginx_ssl_country` | `"US"` | SSL certificate country |
| `nginx_ssl_state` | `"State"` | SSL certificate state |
| `nginx_ssl_locality` | `"City"` | SSL certificate locality |

## Project Structure

```
├── setup.sh                     # Setup script for virtual environment
├── requirements.txt              # Python dependencies
├── requirements.yml              # Ansible collection dependencies
├── roles/
│   └── nginx/
│       ├── defaults/             # Default variables
│       ├── handlers/             # Service handlers
│       ├── tasks/                # Main tasks
│       ├── templates/            # Jinja2 templates
│       ├── molecule/             # Testing scenarios
│       │   ├── default/
│       │   ├── custom-ssl/
│       │   └── http-only/
│       └── meta/                 # Role metadata
└── README.md
```

## Contributing

1. Ensure all tests pass: `molecule test`
2. Follow Ansible best practices
3. Update documentation as needed
4. Test with different scenarios

## Troubleshooting

### Virtual Environment Issues
If you encounter Python dependency issues:
```bash
rm -rf venv/
./setup.sh
```

### Podman Issues
Ensure Podman is installed and your user has access:
```bash
# On RHEL/CentOS/Fedora
sudo dnf install podman

# Test Podman access
podman run --rm hello-world
```

### Collection Issues
If Ansible collections are missing:
```bash
source venv/bin/activate
ansible-galaxy collection install -r requirements.yml --force
```
