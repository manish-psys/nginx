# Nginx Role Quick Start Guide

Get your Nginx web server up and running in minutes with this comprehensive Ansible role.

## 🚀 Quick Start

### 1. Basic Installation

```bash
# Clone the repository
git clone https://github.com/padminisys/nginx.git
cd nginx

# Run the role on your server
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml --limit localhost
```

### 2. Access Your Website

After installation, access your website at:
- **HTTP**: `http://your-server-ip:8080`
- **HTTPS**: `https://your-server-ip:8443` (with self-signed certificate)

## 📋 What Gets Installed

✅ **Nginx 1.29.0** - Latest stable version  
✅ **Hello World Page** - Dynamic HTML with server info  
✅ **SSL/TLS Support** - Self-signed certificates  
✅ **Security Headers** - XSS protection, HSTS, etc.  
✅ **Firewall Rules** - Automatic port configuration  
✅ **Service Management** - Auto-start and enable  

## 🔧 Customization

### HTTP Only (No SSL)

```bash
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml \
  --limit localhost \
  --extra-vars "nginx_ssl_enabled=false nginx_http_port=80"
```

### Custom Ports

```bash
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml \
  --limit localhost \
  --extra-vars "nginx_http_port=9000 nginx_https_port=9443"
```

### Custom SSL Certificate

```bash
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml \
  --limit localhost \
  --extra-vars "nginx_ssl_org='My Company' nginx_ssl_country='IN'"
```

## 🧪 Testing

### Run Molecule Tests

```bash
cd nginx/roles/nginx

# Test all scenarios
molecule test

# Test specific scenario
molecule test --scenario-name default
```

### Manual Verification

```bash
# Check service status
systemctl status nginx

# Test HTTP access
curl -I http://localhost:8080

# Test HTTPS access
curl -k -I https://localhost:8443

# Check SSL certificate
openssl x509 -in /etc/nginx/ssl/nginx-selfsigned.crt -text -noout
```

## 📁 File Locations

- **Web Root**: `/var/www/html/`
- **Configuration**: `/etc/nginx/`
- **SSL Certificates**: `/etc/nginx/ssl/`
- **Logs**: `/var/log/nginx/`

## 🔐 SSL Certificate Information

When SSL is enabled, certificates are stored in `/etc/nginx/ssl/`:

- **Certificate**: `nginx-selfsigned.crt`
- **Private Key**: `nginx-selfsigned.key`
- **CSR**: `nginx-selfsigned.csr`
- **Validity**: 365 days

## 🛠️ Troubleshooting

### Common Issues

1. **Port Already in Use**:
   ```bash
   netstat -tlnp | grep :8080
   systemctl stop conflicting-service
   ```

2. **Firewall Issues**:
   ```bash
   firewall-cmd --permanent --add-port=8080/tcp
   firewall-cmd --permanent --add-port=8443/tcp
   firewall-cmd --reload
   ```

3. **Permission Issues**:
   ```bash
   chown -R nginx:nginx /var/www/html/
   chmod -R 755 /var/www/html/
   ```

### Debug Mode

```bash
# Verbose Ansible output
ansible-playbook -i roles/nginx/tests/inventory roles/nginx/tests/test.yml -vvv

# Molecule debug
molecule --debug converge
```

## 📚 Next Steps

1. **Read the Full Documentation**: [README.md](README.md)
2. **Explore Testing Guide**: [TESTING.md](TESTING.md)
3. **Customize Configuration**: Edit variables in `defaults/main.yml`
4. **Add Your Content**: Replace `/var/www/html/index.html`
5. **Configure Domain**: Update server_name in templates

## 🆘 Support

- **Issues**: https://github.com/padminisys/nginx/issues
- **Documentation**: https://github.com/padminisys/nginx/wiki
- **Email**: xtermous@gmail.com

---

**Happy Web Serving! 🎉** 