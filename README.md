# Nginx Virtual Hosts Creation Script

This Bash script automates the process of creating Nginx virtual hosts on an Ubuntu Server 22.04. It allows you to quickly set up multiple virtual hosts with minimal user input.

## Usage

Before using this script, make sure you have Bash installed on your system. To create Nginx virtual hosts, follow these steps:

1. **Download the Script**: Download the `create-nginx-virtual-hosts.sh` script to your server.

    ```bash
    wget https://github.com/Noct2000/nginx-virtual-hosts-script/raw/main/create-nginx-virtual-hosts.sh
    ```

2. **Make the Script Executable**: If the script is not already executable, run the following command to make it executable:

   ```bash
    sudo chmod +x create-nginx-virtual-hosts.sh
   ```

3. **Run the Script**: Execute the script with the desired virtual hostnames as command-line arguments. For example:

   ```bash
   sudo ./create-nginx-virtual-hosts.sh myhost1.com myhost2.org myhost3.com
   ```

   Replace `myhost1.com`, `myhost2.org`, etc., with your actual virtual hostnames.

4. **Follow the Instructions**: The generete you line that you must to add to your hosts file on your machine

5. **Go to the web page of your host**: Open in your browser page by URL:

    ```
    http://myhost1.com
    ```
     
    Replace `myhost1.com` with your actual virtual hostnames.
    
