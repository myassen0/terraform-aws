# Proxy EC2 Instances
resource "aws_instance" "proxy" {
  count                  = length(var.public_subnet_ids)
  ami                    = var.proxy_ami
  instance_type          = var.proxy_instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.proxy_security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd mod_proxy_html -y
    systemctl start httpd
    systemctl enable httpd

    echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/httpd/conf.modules.d/00-proxy.conf
    echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/httpd/conf.modules.d/00-proxy.conf

    cat <<EOP > /etc/httpd/conf.d/reverse-proxy.conf
    <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/html

      ProxyPreserveHost On
      ProxyPass / http://BACKEND_IP:80/
      ProxyPassReverse / http://BACKEND_IP:80/

      ErrorLog /var/log/httpd/error.log
      CustomLog /var/log/httpd/access.log combined
    </VirtualHost>
    EOP

    systemctl restart httpd
  EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-proxy-${count.index + 1}"
    }
  )
}

# Backend EC2 Instances
resource "aws_instance" "backend" {
  count                  = length(var.private_subnet_ids)
  ami                    = var.backend_ami
  instance_type          = var.backend_instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.backend_security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd -y
    systemctl start httpd
    systemctl enable httpd

    cat <<EOT > /var/www/html/index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>NTI Backend Server</title>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
      <style>
        :root {
          --primary: #0062cc;
          --secondary: #6c757d;
          --success: #28a745;
          --light: #f8f9fa;
          --dark: #343a40;
          --white: #ffffff;
          --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          --radius: 8px;
        }
        
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          font-family: 'Montserrat', sans-serif;
        }
        
        body {
          background: #f5f7fa;
          color: #333;
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 20px;
        }
        
        .container {
          max-width: 800px;
          width: 100%;
          text-align: center;
          overflow: hidden;
          position: relative;
        }
        
        .nti-logo-container {
          margin-bottom: 40px;
          position: relative;
          display: inline-block;
        }
        
        .nti-logo-img {
          max-width: 300px;
          height: auto;
          margin-bottom: 20px;
        }
        
        .nti-full-name {
          position: relative;
          font-size: 18px;
          font-weight: 600;
          color: #666;
          letter-spacing: 1px;
          margin-top: 15px;
        }
        
        h1 {
          font-size: 32px;
          margin-bottom: 40px;
          color: #333;
          font-weight: 600;
        }
        
        .server-info {
          background-color: #f8f9fa;
          padding: 30px;
          border-radius: 15px;
          text-align: left;
          border-left: 5px solid #0062cc;
          box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
          margin-bottom: 40px;
        }
        
        .server-info h2 {
          font-size: 24px;
          margin-bottom: 25px;
          color: #0062cc;
          font-weight: 600;
          display: flex;
          align-items: center;
        }
        
        .server-info h2::before {
          content: "⚙️";
          margin-right: 10px;
          font-size: 28px;
        }
        
        .server-info p {
          margin-bottom: 20px;
          font-size: 16px;
          line-height: 1.6;
          display: flex;
          align-items: center;
        }
        
        .server-info p strong {
          min-width: 140px;
          display: inline-block;
          color: #555;
        }
        
        .server-info code {
          background-color: #e9ecef;
          padding: 8px 12px;
          border-radius: 5px;
          font-family: "Courier New", monospace;
          color: #333;
          font-size: 15px;
          border-left: 3px solid #0062cc;
          flex: 1;
        }
        
        .credits {
          margin-top: 30px;
          text-align: center;
        }
        
        .credits p {
          font-size: 16px;
          margin-bottom: 10px;
          color: #555;
          font-weight: 500;
        }
        
        .footer {
          margin-top: 40px;
          font-size: 14px;
          color: #888;
          position: relative;
          padding-top: 20px;
        }
        
        .footer::before {
          content: "";
          position: absolute;
          top: 0;
          left: 25%;
          width: 50%;
          height: 1px;
          background: #ddd;
        }
        
        @media (max-width: 768px) {
          .nti-logo-img {
            max-width: 200px;
          }
          
          h1 {
            font-size: 24px;
          }
          
          .server-info p strong {
            min-width: 120px;
          }
        }
      </style>
    </head>
    <body>
        <div class="container">
            <div class="nti-logo-container">
                <img src="https://www.nti.sci.eg/images/logo.png" alt="NTI Logo" class="nti-logo-img">
                <div class="nti-full-name">National Telecommunication Institute</div>
            </div>
            <h1>AWS Infrastructure Backend Server</h1>
            
            <div class="server-info">
                <h2>Server Information</h2>
                <p><strong>Hostname:</strong> <code>$(hostname)</code></p>
                <p><strong>Region:</strong> <code>us-east-1</code></p>
                <p><strong>Availability Zone:</strong> <code>us-east-1b</code></p>
            </div>
            
            <div class="credits">
                <p>Developed by: Mahmoud Yassen</p>
                <p>Supervised by: Eng. Mohamed Swelam</p>
            </div>
            
            <div class="footer">
                &copy; 2025 NTI AWS Infrastructure Project
            </div>
        </div>
    </body>
    </html>
    EOT

    systemctl restart httpd
  EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-backend-${count.index + 1}"
    }
  )
}

# Null resource to configure reverse proxy after provisioning
resource "null_resource" "configure_proxy" {
  count = length(aws_instance.proxy)

  triggers = {
    proxy_instance_id   = aws_instance.proxy[count.index].id
    backend_instance_id = aws_instance.backend[count.index % length(aws_instance.backend)].id
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = aws_instance.proxy[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
      # Wait for config file to exist
      "for i in {1..10}; do [ -f /etc/httpd/conf.d/reverse-proxy.conf ] && break || sleep 5; done",
      # Replace BACKEND_IP placeholder
      "sudo sed -i 's|BACKEND_IP|${aws_instance.backend[count.index % length(aws_instance.backend)].private_ip}|' /etc/httpd/conf.d/reverse-proxy.conf",
      # Restart Apache
      "sudo systemctl restart httpd"
    ]
  }

  depends_on = [
    aws_instance.proxy,
    aws_instance.backend
  ]
}
