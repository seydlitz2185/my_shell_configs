ls -la
exit
ls -la
cd ~
ls -la
test.sh
./test.sh
bash
exit
ls
#!/bin/bash
# 检查是否以 root 权限运行
if [[ $EUID -ne 0 ]]; then     echo "请使用 root 权限运行此脚本";     exit 1; fi
# 配置彩色显示
configure_bash_colors() {     local bashrc="$HOME/.bashrc";          echo "配置 Bash 彩色提示符..."; 
    echo 'PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "' >> "$bashrc";     echo "已为 Bash 启用彩色显示"; }
# 配置动态补全
configure_dynamic_completion() {     local bashrc="$HOME/.bashrc";          echo "配置 Bash 动态补全功能..."; 
    cat << 'EOF' >> "$bashrc"

# 动态补全函数
_dynamic_completion_example() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 根据不同上下文生成补全内容
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

# 将动态补全绑定到命令
complete -F _dynamic_completion_example mycommand

EOF
      echo "已为 Bash 配置动态补全"; }
# 主函数
main() {     configure_bash_colors;     configure_dynamic_completion;     echo "脚本执行完毕，请重新启动终端以应用更改。"; }
main
#!/bin/bash
# 检查是否以 root 权限运行
if [[ $EUID -ne 0 ]]; then     echo "请使用 root 权限运行此脚本";     exit 1; fi
# 配置彩色显示
configure_bash_colors() {     local bashrc="$HOME/.bashrc";          echo "配置 Bash 彩色提示符..."; 
    echo 'PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "' >> "$bashrc";     echo "已为 Bash 启用彩色显示"; }
# 配置动态补全
configure_dynamic_completion() {     local bashrc="$HOME/.bashrc";          echo "配置 Bash 动态补全功能..."; 
    cat << 'EOF' >> "$bashrc"

# 动态补全函数
_dynamic_completion_example() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 根据不同上下文生成补全内容
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

# 将动态补全绑定到命令
complete -F _dynamic_completion_example mycommand

EOF
      echo "已为 Bash 配置动态补全"; }
# 主函数
main() {     configure_bash_colors;     configure_dynamic_completion;     echo "脚本执行完毕，请重新启动终端以应用更改。"; }
main
:wq
bash
exit
ls
exit
