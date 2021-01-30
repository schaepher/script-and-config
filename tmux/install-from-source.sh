#!/bin/bash

# 默认在用户目录安装。适用于无法获取 root 权限的场景。

curl ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz -O
curl -LO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
curl -LO https://github.com/tmux/tmux/releases/download/3.1/tmux-3.1.tar.gz
curl -O http://ftp.gnu.org/gnu/bison/bison-3.7.4.tar.gz
curl -O http://ftp.gnu.org/gnu/m4/m4-latest.tar.gz

tar xzf ncurses.tar.gz 
tar xzf libevent-2.1.12-stable.tar.gz
tar xzf tmux-3.1.tar.gz 
tar xzf bison-3.7.4.tar.gz
tar xzf m4-latest.tar.gz

export PATH=$PATH:$HOME/bin/tmuxdeps/bin

cd libevent-2.1.12-stable
./configure  --prefix=$HOME/bin/tmuxdeps --enable-shared
make && make install

cd ncurses
./configure  --prefix=$HOME/bin/tmuxdeps --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$HOME/bin/tmuxdeps/lib/pkgconfig
make && make install

cd m4-latest
./configure --prefix=$HOME/bin/tmuxdeps
make && make install

cd bison-3.7.4
./configure --prefix=$HOME/bin/tmuxdeps
make && make install

cd tmux-3.1
PKG_CONFIG_PATH=$HOME/bin/tmuxdeps/lib/pkgconfig ./configure --prefix=$HOME
make && make install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/bin/tmuxdeps/lib