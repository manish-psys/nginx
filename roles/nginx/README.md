# Nginx Web Server Role

A comprehensive Ansible role for deploying and configuring Nginx web server on Red Hat family systems (CentOS, RHEL, Fedora).

## Features

- 🚀 **Hello World HTML Page**: Serves a dynamic "Hello World" page on custom port (default: 8080)
- 🔒 **SSL/TLS Support**: Self-signed certificate generation for HTTPS (default: 8443)
- 🛡️ **Security Headers**: Configurable security headers for enhanced protection
- 🔥 **Firewall Integration**: Automatic firewall configuration with firewalld
- 📊 **Comprehensive Logging**: Detailed access and error logging
- ⚙️ **Highly Configurable**: Extensive variable customization options

## Requirements

- Ansible 2.9+
- Red Hat family OS (CentOS 7+, RHEL 7+, Fedora)
- Python 3.6+
- Root or sudo privileges

## Role Variables

### Core Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `nginx_version` | "1.29.0" | Nginx version to install |
| `nginx_web_root` | "/var/www/html" | Web root directory |
| `nginx_http_port` | 8080 | HTTP port |
| `nginx_https_port` | 8443 | HTTPS port |

### SSL/TLS Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `nginx_ssl_enabled` | true | Enable SSL/TLS |
| `nginx_ssl_dir` | "/etc/nginx/ssl" | SSL certificates directory |
| `nginx_ssl_org` | "Test Organization" | SSL certificate organization |
| `nginx_ssl_ou` | "IT Department" | SSL certificate organizational unit |
| `nginx_ssl_country` | "US" | SSL certificate country |
| `nginx_ssl_state` | "California" | SSL certificate state |
| `nginx_ssl_locality` | "San Francisco" | SSL certificate locality |

### Security & Performance

| Variable | Default | Description |
|----------|---------|-------------|
| `nginx_firewall_enabled` | true | Enable firewall configuration |
| `nginx_security_headers` | true | Enable security headers |
| `nginx_worker_processes` | "auto" | Number of worker processes |
| `nginx_worker_connections` | 1024 | Worker connections |

## Dependencies

None

## Example Playbook

### Basic Usage

```yaml
- hosts: webservers
  roles:
    - nginx
```

### Custom Configuration

```yaml
- hosts: webservers
  vars:
    nginx_http_port: 8080
    nginx_https_port: 8443
    nginx_ssl_enabled: true
    nginx_ssl_org: "My Company"
    nginx_firewall_enabled: true
  roles:
    - nginx
```

### HTTP Only (No SSL)

```yaml
- hosts: webservers
  vars:
    nginx_ssl_enabled: false
    nginx_http_port: 80
  roles:
    - nginx
```

## Use Cases

### 🚀 Use Case 1: Hello World on Port 8080

The role automatically creates and serves a "Hello World" HTML page with:
- Dynamic server information
- Real-time clock display
- Responsive styling
- Accessible on `http://your-server:8080`

### 🌐 Use Case 2: Encrypted HTTPS Access

When SSL is enabled, the role provides:
- Self-signed SSL certificate generation
- HTTPS access on port 8443
- Modern TLS 1.2/1.3 protocols
- Security headers including HSTS
- Accessible on `https://your-server:8443`

### 🔧 Use Case 3: Production-Ready Configuration

The role includes:
- Optimized worker processes
- Security headers
- Access control for hidden files
- Comprehensive logging
- Firewall integration

## SSL Certificate Information

When SSL is enabled, certificates are stored in `/etc/nginx/ssl/`:

- **Certificate**: `nginx-selfsigned.crt`
- **Private Key**: `nginx-selfsigned.key`
- **CSR**: `nginx-selfsigned.csr`
- **Validity**: 365 days
- **Key Size**: 2048 bits

## Access URLs

After deployment, access your site at:

- **HTTP**: `http://your-server:8080`
- **HTTPS**: `https://your-server:8443` (if SSL enabled)

## Testing

### Manual Testing

1. **HTTP Test**:
   ```bash
   curl -I http://your-server:8080
   ```

2. **HTTPS Test**:
   ```bash
   curl -k -I https://your-server:8443
   ```

3. **SSL Certificate Info**:
   ```bash
   openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -text -noout
   ```

### Molecule Testing

Run the included molecule tests:

```bash
cd roles/nginx
molecule test
```

## License

GPL-2.0-or-later

## Author Information

Created by Manish <xtermous@gmail.com>

## Support

- **Repository**: https://github.com/padminisys/nginx
- **Documentation**: https://github.com/padminisys/nginx/wiki
- **Issues**: https://github.com/padminisys/nginx/issues
