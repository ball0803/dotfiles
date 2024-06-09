#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
	tmux attach -t default || tmux new -s default
fi

alias ls='eza -a'
alias ll='eza -alh'
alias tree='eza --tree'
alias grep='grep --color=auto'
eval "$(zoxide init bash)"
eval "$(oh-my-posh init bash)"
eval "$(oh-my-posh prompt init bash --config /usr/share/oh-my-posh/themes/lambdageneration.omp.json)"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

PS1='[\u@\h \W]\$ '
