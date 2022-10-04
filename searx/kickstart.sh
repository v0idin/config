apt update && apt dist-upgrade -y
apt install -y docker.io docker-compose plocate mc
updatedb

mv /etc/ssh/sshd_config /etc/ssh/sshd_config_init
cp sshd_config /etc/ssh/sshd_config

ufw allow 52022/tcp
ufw allow http
ufw allow https
ufw default deny incoming
ufw default allow outgoing
ufw enable

cd /usr/local
git clone https://github.com/searxng/searxng-docker.git
cd searxng-docker
nano .env

echo "press any key to continue..."

sed -i "s|ultrasecretkey|$(openssl rand -hex 32)|g" searxng/settings.yml
echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
sysctl vm.overcommit_memory=1
cd /usr/local/searxng-docker/
cp searxng-docker.service.template searxng-docker.service
nano searxng-docker.service

/usr/local/bin/docker-compose -f docker-compose.yaml --remove-orphans

echo "press any key to continue..."

systemctl start searxng-docker.service
systemctl enable $(pwd)/searxng-docker.service
