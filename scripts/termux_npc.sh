#!/data/data/com.termux/files/usr/bin/sh

basedir="~/npc"

mkdir ${basedir}
cd ${basedir}
curl -L -o npc.tgz https://github.com/ehang-io/nps/releases/download/v0.26.9/linux_arm_v7_client.tar.gz
tar xvzf npc.tgz

printf "enter server_addr: "
read the_server_addr
printf "enter vkey: "
read the_key

echo """
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
""" | sed "s/the_server_addr/${the_server_addr}/" | sed "s/the_key/${the_key}/" > ${basedir}/conf/npc.conf

