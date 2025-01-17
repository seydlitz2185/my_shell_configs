#!/bin/bash

# 检查是否以 root 权限运行
if [[ $EUID -ne 0 ]]; then
    echo "请使用 root 权限运行此脚本"
    exit 1
fi

# 检测 Linux 发行版
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO=$ID
    elif [[ -f /etc/lsb-release ]]; then
        . /etc/lsb-release
        DISTRO=$DISTRIB_ID
    else
        echo "无法检测当前的 Linux 发行版"
        exit 1
    fi
    echo "检测到的发行版为：$DISTRO"
}

# 安装必要的软件
install_dependencies() {
    echo "安装必要的依赖项..."

    case "$DISTRO" in
        ubuntu|debian)
            apt update
            apt install -y bash-completion fzf
            ;;
        centos|rhel|fedora|rocky|almalinux)
            yum install -y bash-completion fzf
            ;;
        arch|manjaro)
            pacman -Sy --noconfirm bash-completion fzf
            ;;
        opensuse|suse)
            zypper install -y bash-completion fzf
            ;;
        *)
            echo "不支持的发行版：$DISTRO，请手动安装 bash-completion 和 fzf"
            exit 1
            ;;
    esac

    echo "依赖项安装完成！"
}

# 配置彩色显示
configure_bash_colors() {
    local bashrc="$HOME/.bashrc"
    
    echo "配置 Bash 彩色提示符..."

    # 添加彩色提示符到 .bashrc
    echo 'PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "' >> "$bashrc"
    echo "已为 Bash 启用彩色显示"
}


# 主函数
main() {
    detect_distro
    install_dependencies
    configure_bash_colors
    echo "脚本执行完毕，请重新启动终端以应用更改。"
}

main
