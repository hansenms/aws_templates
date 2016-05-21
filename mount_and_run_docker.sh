relayname=$1

mkdir -p /gtmount/gtlog
mkdir -p /gtmount/gtdependencies 
echo "${relayhostname}:/home/shares/gtlog /gtmount/gtlog nfs rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
echo "${relayhostname}:/home/shares/gtdependencies /gtmount/gtdependencies nfs rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
mount -a
