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

# 配置自定义动态补全功能
configure_dynamic_completion() {
    local bashrc="$HOME/.bashrc"
    
    echo "配置 Bash 动态补全功能..."

    # 添加动态补全函数
    cat << 'EOF' >> "$bashrc"

# 动态补全函数示例
_dynamic_completion_example() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 根据上下文生成补全内容
    case "${COMP_CWORD}" in
        1)
            COMPREPLY=( $(compgen -W "start stop restart status" -- "$cur") )
            ;;
        2)
            COMPREPLY=( $(compgen -f -- "$cur") )
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

# 将动态补全绑定到命令 mycommand
complete -F _dynamic_completion_example mycommand

EOF

    echo "已为 Bash 配置动态补全"
}

# 配置动态历史补全功能
configure_dynamic_history_completion() {
    local bashrc="$HOME/.bashrc"

    echo "配置 Bash 历史动态补全功能..."

    # 添加历史记录补全功能到 .bashrc
    cat << 'EOF' >> "$bashrc"

# 配置历史记录
export HISTSIZE=10000  # 设置最大历史记录条数
export HISTFILESIZE=20000  # 设置保存到文件的最大记录条数
export HISTCONTROL=ignoredups:erasedups  # 去重并忽略重复的连续命令
export HISTIGNORE="ls:bg:fg:exit"  # 忽略指定命令
shopt -s histappend  # 追加历史记录，而不是覆盖

# 动态历史补全函数
_dynamic_history_completion() {
    local cur history_match
    cur="${COMP_WORDS[COMP_CWORD]}"

    # 使用 fzf 搜索历史记录
    history_match=$(history | awk '{$1=""; print $0}' | grep -- "$cur" | fzf --height 40% --reverse --query="$cur")

    # 如果匹配成功，将其作为补全结果
    if [[ -n "$history_match" ]]; then
        COMPREPLY=( "$history_match" )
    else
        COMPREPLY=()
    fi
}

# 绑定动态历史补全到所有命令
complete -o default -o bashdefault -F _dynamic_history_completion ''

# 启用 fzf 快捷键绑定（Ctrl+R）
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

EOF

    echo "已为 Bash 配置历史动态补全功能"
}

# 主函数
main() {
    detect_distro
    install_dependencies
    configure_bash_colors
    configure_dynamic_completion
    configure_dynamic_history_completion
    echo "脚本执行完毕，请重新启动终端以应用更改。"
}

main
