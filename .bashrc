#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
	tmux attach -t default || tmux new -s default
fi

alias ls='eza -a --icons=auto'
alias ll='eza -alh --icons=auto'
alias tree='eza --tree --icons=auto'
alias grep='grep --color=auto'
eval "$(zoxide init bash)"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
eval "$(oh-my-posh init bash)"
eval "$(oh-my-posh prompt init bash --config /usr/share/oh-my-posh/themes/lambdageneration.omp.json)"

PS1='[\u@\h \W]\$ '
