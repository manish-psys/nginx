# Nginx Role Testing Guide

This document provides comprehensive testing instructions for the Nginx role using Molecule and manual verification methods.

## Prerequisites

- Ansible 2.9+
- Molecule 3.0+
- Podman or Docker
- Python 3.6+
- Red Hat family OS for manual testing

## Molecule Testing

### Available Scenarios

The role includes three molecule scenarios:

1. **default** - Full configuration with SSL/TLS
2. **http-only** - HTTP-only configuration
3. **custom-ssl** - Custom SSL certificate configuration

### Running All Tests

```bash
cd nginx/roles/nginx

# Run all scenarios
molecule test

# Run specific scenario
molecule test --scenario-name default
molecule test --scenario-name http-only
molecule test --scenario-name custom-ssl
```

### Individual Molecule Commands

```bash
# Create test instances
molecule create

# Converge (apply role)
molecule converge

# Verify (run tests)
molecule verify

# Destroy test instances
molecule destroy

# Login to test instance
molecule login --host centos8
```

### Scenario Details

#### Default Scenario
- **Platforms**: CentOS 8, CentOS 9, RHEL 8
- **Configuration**: Full SSL/TLS with default settings
- **Ports**: HTTP 8080, HTTPS 8443
- **Tests**: Complete verification including SSL certificates

#### HTTP-Only Scenario
- **Platforms**: CentOS 8
- **Configuration**: HTTP only, no SSL
- **Ports**: HTTP 80
- **Tests**: Verifies SSL is properly disabled

#### Custom SSL Scenario
- **Platforms**: CentOS 8
- **Configuration**: Custom SSL certificate details
- **Ports**: HTTP 8080, HTTPS 8443
- **Tests**: Validates custom SSL certificate attributes

## Manual Testing

### Prerequisites for Manual Testing

1. **Red Hat Family System**:
   - CentOS 7/8/9
   - RHEL 7/8/9
   - Fedora 34+

2. **System Requirements**:
   - Root or sudo access
   - Internet connectivity for package installation
   - At least 1GB RAM
   - 10GB free disk space

### Running Manual Tests

#### 1. Basic Installation Test

```bash
# Clone the repository
git clone https://github.com/padminisys/nginx.git
cd nginx

# Run basic test
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml --limit localhost
```

#### 2. HTTP-Only Test

```bash
# Test HTTP-only configuration
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml \
  --limit localhost \
  --extra-vars "nginx_ssl_enabled=false nginx_http_port=80"
```

#### 3. Custom SSL Test

```bash
# Test custom SSL configuration
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml \
  --limit localhost \
  --extra-vars "nginx_ssl_org='My Company' nginx_ssl_country='IN'"
```

### Manual Verification Steps

#### 1. Service Verification

```bash
# Check Nginx service status
systemctl status nginx

# Check if Nginx is enabled
systemctl is-enabled nginx

# Check Nginx process
ps aux | grep nginx
```

#### 2. Port Verification

```bash
# Check listening ports
netstat -tlnp | grep nginx
ss -tlnp | grep nginx

# Test HTTP access
curl -I http://localhost:8080
curl -I http://localhost:80  # if using port 80

# Test HTTPS access (if SSL enabled)
curl -k -I https://localhost:8443
```

#### 3. File Verification

```bash
# Check web root
ls -la /var/www/html/
cat /var/www/html/index.html

# Check SSL certificates (if enabled)
ls -la /etc/nginx/ssl/
openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -text -noout
```

#### 4. Configuration Verification

```bash
# Test Nginx configuration
nginx -t

# Check configuration files
cat /etc/nginx/nginx.conf
cat /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/ssl.conf  # if SSL enabled
```

#### 5. Firewall Verification

```bash
# Check firewall rules
firewall-cmd --list-ports
firewall-cmd --list-services

# Test firewall rules
firewall-cmd --query-port=8080/tcp
firewall-cmd --query-port=8443/tcp  # if SSL enabled
```

#### 6. Log Verification

```bash
# Check Nginx logs
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log

# Check system logs
journalctl -u nginx -f
```

### Browser Testing

1. **HTTP Access**:
   - Open browser: `http://your-server-ip:8080`
   - Should display "Hello, World!" page

2. **HTTPS Access** (if SSL enabled):
   - Open browser: `https://your-server-ip:8443`
   - Accept self-signed certificate warning
   - Should display "Hello, World!" page

### SSL Certificate Testing

```bash
# Verify certificate details
openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -text -noout

# Test SSL connection
openssl s_client -connect localhost:8443 -servername localhost

# Check certificate expiration
openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -noout -dates
```

## Troubleshooting

### Common Issues

#### 1. Port Already in Use
```bash
# Check what's using the port
netstat -tlnp | grep :8080
lsof -i :8080

# Stop conflicting service
systemctl stop conflicting-service
```

#### 2. Firewall Issues
```bash
# Check firewall status
systemctl status firewalld

# Manually add ports
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-port=8443/tcp
firewall-cmd --reload
```

#### 3. SELinux Issues
```bash
# Check SELinux status
getenforce

# Allow Nginx ports in SELinux
semanage port -a -t http_port_t -p tcp 8080
semanage port -a -t http_port_t -p tcp 8443
```

#### 4. Permission Issues
```bash
# Fix web root permissions
chown -R nginx:nginx /var/www/html/
chmod -R 755 /var/www/html/

# Fix SSL certificate permissions
chown nginx:nginx /etc/nginx/ssl/nginx-selfsigned.crt
chmod 644 /etc/nginx/ssl/nginx-selfsigned.crt
chown nginx:nginx /etc/nginx/ssl/nginx-selfsigned.key
chmod 600 /etc/nginx/ssl/nginx-selfsigned.key
```

### Debug Mode

Run tests with verbose output:

```bash
# Molecule with debug
molecule --debug converge

# Ansible with verbose output
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml -vvv
```

## Test Results

### Expected Output

Successful test runs should show:

```
✅ Nginx Role Verification Complete!

📋 Test Results:
- Nginx Package: ✅ Installed
- Nginx Service: ✅ Running & Enabled
- Web Root: ✅ /var/www/html
- Index HTML: ✅ Hello World Page
- HTTP Port: ✅ 8080
- Configuration: ✅ Valid
- SSL Certificate: ✅ Generated
- HTTPS Port: ✅ 8443
- SSL Files: ✅ /etc/nginx/ssl/
- Firewall: ✅ Configured

🌐 Access URLs:
- HTTP: http://your-server:8080
- HTTPS: https://your-server:8443
```

### Performance Metrics

- **Installation Time**: < 2 minutes
- **Memory Usage**: < 50MB
- **Disk Usage**: < 100MB
- **Startup Time**: < 5 seconds

## Continuous Integration

The role includes GitHub Actions workflows for automated testing:

- **Molecule Tests**: Run on every commit
- **Linting**: Ansible-lint validation
- **Security**: Bandit security scanning
- **Documentation**: Link checking

## Support

For testing issues or questions:

- **Issues**: https://github.com/padminisys/nginx/issues
- **Documentation**: https://github.com/padminisys/nginx/wiki
- **Email**: xtermous@gmail.com 