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

# 把脚本放到桌面点击执行，需要安装 Termux:Widget
# .shortcuts 目录下的脚本执行时会启动 Termux 会话，在前台展示
# .shortcuts/tasks 里的脚本会在后台执行
mkdir -p ~/.shortcuts
mkdir -p ~/.shortcuts/tasks

# nps 客户端
echo """
#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
~/npc/npc -config ~/npc/conf/npc.conf
""" > ~/.shortcuts/tasks/npc

# SSH 服务端
echo """
#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
sshd
""" > ~/.shortcuts/tasks/sshd

# 开机自启动脚本。需要安装 Termux:Boot
mkdir -p ~/.termux/boot

# 安装到自启动
echo """
#!/data/data/com.termux/files/usr/bin/sh
cp ~/.shortcuts/tasks/sshd ~/.termux/boot/sshd
rm ~/.shortcuts/tasks/sshd
""" > ~/.shortcuts/tasks/start-sshd-onboot

echo """
#!/data/data/com.termux/files/usr/bin/sh
cp ~/.shortcuts/tasks/npc ~/.termux/boot/npc
rm ~/.shortcuts/tasks/npc
""" > ~/.shortcuts/tasks/start-npc-onboot