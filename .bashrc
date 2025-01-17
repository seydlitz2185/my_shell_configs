PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "

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

PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "

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

PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0m\] \$ "

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

