#!/bin/bash

clear

echo 'root 설정'
sudo passwd root

su

echo 'ssh 세팅'
sudo apt install openssh-server -y

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

sudo service ssh restart

echo '# 패키지 업데이트 / 업그레이드 / 청소'
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

echo '# nano 설치'
sudo apt install nano -y
echo

echo '# 시간대 설정'
sudo ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sudo apt install tzdata -y
echo

echo '# 시간 동기화'
CONF=/etc/systemd/timesyncd.conf
sudo sed -i 's/^#//g' $CONF && sudo sed -i 's/^NTP=/NTP=kr.pool.ntp.org/g' $CONF
timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd.service
timedatectl
echo

echo '# rclone 설치'
curl -fsSL https://raw.githubusercontent.com/wiserain/rclone/mod/install.sh | sudo bash
echo

echo '# Docker 설치'
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
echo