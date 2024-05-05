#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -a'
alias ll='eza -alh'
alias tree='eza --tree'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(oh-my-posh init bash)"
eval $(oh-my-posh prompt init bash --config /usr/share/oh-my-posh/themes/easy-term.omp.json)
alias config='/usr/bin/git --git-dir=/home/camel/dotfiles/ --work-tree=/home/camel'
