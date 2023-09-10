#!/bin/bash

args=("$@")
args_count="$#"

if [ $args_count -eq 0 ]; then
    echo "No command-line arguments provided."
    echo "Please enter at least one virtual hostname for nginx"
    echo "Example:"
    echo "./create-nginx-virtual-hosts.sh myhost1.com myhost2.org myhost3.com ..."
else
    # Check if OpenSSH Server is installed
    if ! dpkg -l | grep -q "openssh-server"; then
        echo "OpenSSH Server is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y openssh-server
    else
        echo "OpenSSH Server is already installed."
    fi

    # Check if Nginx is installed
    if ! dpkg -l | grep -q "nginx"; then
        echo "Nginx is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y nginx
    else
        echo "Nginx is already installed."
    fi

    # Stop nginx
    sudo systemctl stop nginx

    # Loop through all virtual hostnames
    for arg in "${args[@]}"; do
        echo "Creating: $args virtual host"
        echo "Prepare host config for: $args virtual host"
        base_virtual_host_config="
        # Virtual Host configuration for ${arg}
        #
        # You can move that to a different file under sites-available/ and symlink that
        # to sites-enabled/ to enable it.
        #
        server {
                listen 80;
                listen [::]:80;

                server_name ${arg};

                root /var/www/${arg}/html;
                index index.html;

                location / {
                        try_files \$uri \$uri/ =404;
                }
        }
        "
        echo "Success"
        echo "Write config to /etc/nginx/sites-available/${arg}"
        echo "$base_virtual_host_config" | sudo tee "/etc/nginx/sites-available/${arg}" > /dev/null
        echo "Success"
        echo "Create base page for ${arg} virtual host"
        sudo mkdir -p /var/www/${arg}/html
        sudo chown -R $USER:$USER /var/www/${arg}/html
        sudo ln -s /etc/nginx/sites-available/${arg} /etc/nginx/sites-enabled/${arg}
        base_web_page="
        <html>
            <body>
                Hello from ${arg}
            </body>
        </html>
        "
        echo "$base_web_page" | sudo tee "/var/www/${arg}/html/index.html" > /dev/null
        echo "Success"
    done
    echo "Fix error hash bucket memory"
    sudo sed -i 's/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/' /etc/nginx/nginx.conf
    echo "Success"
    echo "Start nginx"
    sudo systemctl start nginx
    echo "Get ip"
    ip_address=$(hostname -I)
    echo "Success"
    echo "Please add follow line to your hosts file"
    echo "${ip_address} ${args[@]}"
    echo "Usual Windows path: \"C:\\Windows\\System32\\drivers\\etc\\hosts\""
    echo "Usual Linux path: \"/etc/hosts\""
fi