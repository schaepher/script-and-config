#!/data/data/com.termux/files/usr/bin/sh

basedir=~/npc

mkdir ${basedir}
cd ${basedir}
curl -L -o npc.tgz https://github.com/ehang-io/nps/releases/download/v0.26.9/linux_arm_v7_client.tar.gz
tar xvzf npc.tgz

printf "enter domain or ip: "
read domain
printf "enter port: "
read port
printf "enter vkey: "
read key

cat > ${basedir}/conf/npc.conf <<EOF
[common]
server_addr=the_server_addr
conn_type=tcp
vkey=the_key
auto_reconnection=true
max_conn=1000
flow_limit=1000
rate_limit=1000
#basic_username=11
#basic_password=3
#web_username=user
#web_password=1234
crypt=true
compress=true
#pprof_addr=0.0.0.0:9999
disconnect_timeout=60
EOF

sed -i "s/the_key/${key}/" ${basedir}/conf/npc.conf

# nps 客户端
cat > ~/.shortcuts/tasks/npc <<`EOF`
#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
ip=$(ping -c 1 domain  | head -n 1 | awk '{print $3}' | sed 's/[\(\)]//g')
sed -i "s/^server_addr=.*\$/server_addr=${ip}:port/g" npc.conf
~/npc/npc -config ~/npc/conf/npc.conf
`EOF`

sed -i "s/domain/${domain}/" ~/.shortcuts/tasks/npc
sed -i "s/port/${port}/" ~/.shortcuts/tasks/npc

cat > ~/.shortcuts/tasks/start-npc-onboot <<EOF
#!/data/data/com.termux/files/usr/bin/sh
cp ~/.shortcuts/tasks/npc ~/.termux/boot/npc
rm ~/.shortcuts/tasks/npc
EOF