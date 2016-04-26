smbhostname=$1

mkdir -p /gtmount/gtlog
mkdir -p /gtmount/gtdependencies 
echo "//${smbhostname}/gtlog /gtmount/gtlog cifs guest,vers=3.0,dir_mode=0777,file_mode=0777" >> /etc/fstab
echo "//${smbhostname}/gtdependencies /gtmount/gtdependencies cifs guest,vers=3.0,dir_mode=0777,file_mode=0777" >> /etc/fstab
mount -a
