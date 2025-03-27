#!/bin/bash

# 更新软件包索引，确保系统是最新的
sudo apt update
sudo apt upgrade -y

# 安装必要的依赖工具，支持通过 HTTPS 下载软件包
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 添加 Docker 的官方 GPG 密钥，确保软件包来源可信
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加 Docker 的 APT 仓库，根据当前系统版本自动配置
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 再次更新软件包索引，包含 Docker 仓库
sudo apt update

# 安装 Docker 相关软件包
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 验证 Docker 是否安装成功
docker --version

# 将当前用户添加到 Docker 组，避免每次运行需要 sudo（需要重新登录生效）
sudo usermod -aG docker $USER

# 下载并安装 Docker Compose（版本 2.23.0，可根据需要替换为最新版本）
sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 为 Docker Compose 添加执行权限
sudo chmod +x /usr/local/bin/docker-compose

# 验证 Docker Compose 是否安装成功
docker-compose --version

# 可选：运行一个简单的测试容器，验证 Docker 是否正常工作
# sudo docker run hello-world