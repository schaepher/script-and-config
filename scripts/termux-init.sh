#!/data/data/com.termux/files/usr/bin/sh

sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
apt update && apt upgrade

# 想使用 termux-api，需要安装 Termux:API
apt install vim openssh termux-api

# SSH 公钥。貌似只能通过公钥登录 Termux 的 SSH。
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
printf "enter SSH public key: "
read ssh_public_key
echo ${ssh_public_key} >> ~/.ssh/authorized_keys

# 把脚本放到桌面点击执行，需要安装 Termux:Widget
# .shortcuts 目录下的脚本执行时会启动 Termux 会话，在前台展示
# .shortcuts/tasks 里的脚本会在后台执行
mkdir -p ~/.shortcuts
mkdir -p ~/.shortcuts/tasks

# SSH 服务端
cat > ~/.shortcuts/tasks/sshd <<EOF
#!/data/data/com.termux/files/usr/bin/sh
sshd
EOF

cat > ~/.shortcuts/tasks/stop-sshd <<'EOF'
#!/data/data/com.termux/files/usr/bin/sh
target=sshd
kill $(ps x | grep ${target} | grep -v grep | grep -v bin | awk '{print $1}')
EOF

# 避免系统休眠
cat > ~/.shortcuts/tasks/wakelock <<EOF
#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
EOF

# 开机自启动脚本。需要安装 Termux:Boot
mkdir -p ~/.termux/boot

# 安装到自启动
cat > ~/.shortcuts/tasks/start-sshd-onboot <<EOF
#!/data/data/com.termux/files/usr/bin/sh
cp ~/.shortcuts/tasks/sshd ~/.termux/boot/sshd
rm ~/.shortcuts/tasks/start-sshd-onboot
EOF