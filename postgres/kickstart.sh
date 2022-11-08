apt update && apt dist-upgrade -y
apt install -y plocate mc nftables 
updatedb

mv /etc/ssh/sshd_config /etc/ssh/sshd_config_init
cp sshd_config /etc/ssh/sshd_config

ufw allow 52022/tcp
ufw default deny incoming
ufw default allow outgoing
ufw enable

systemctl restart sshd
