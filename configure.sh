#!/usr/bin/bash


#set apt source to tsinghua
read -p "use the mirror of tsinghua and move old sources.list to sources.list.backup?(y/n):" arg
if [ -z "$arg" ] -o [ "$arg" = "y" -o "$arg" = "Y" ];then
    mv /etc/apt/sources.list /etc/apt/sources.list.backup
    cp sources.list /etc/apt/sources.list 
fi

#install softwares
apt update
software=(gcc g++ python3 pip3 git vim)
for i in "${software[@]}";
do
    $i --version > /dev/null 2>&1
    if [ $? -ne 0 ];then
        read -p "install $i?(y/n):" arg
        if [ -z "$arg" ] -o [ "$arg" = "y" -o "$arg" = "Y" ];then
            apt install $i
        fi
    fi

done

#set pip source to tsinghua
read -p "set pip3 mirror to tsinghua(y/n):" arg
if [ -z "$arg" ] -o [ "$arg" = "y" -o "$arg" = "Y" ];then
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
fi


#download and install vscode
vscode=https://vscode.cdn.azure.cn/stable/2af051012b66169dde0c4dfae3f5ef48f787ff69/code_1.49.3-1601661857_amd64.deb
read -p "get vscode from $vscode and install(y/n):" arg
if [ -z "$arg" ] -o [ "$arg" = "y" -o "$arg" = "Y" ];then
    wget $vscode -O vscode.deb -o vscode_download.log
    dpkg -i vscode.deb
fi
