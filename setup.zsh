# Basic zsh config
autoload -Uz compinit && compinit # Enable completion system
zstyle ':completion:*' menu select # Enable menu selection for completion

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz colors && colors
PS1="%B%{$fg[blue]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}$ %b"

### Search history with arrow keys
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search # Register up-line-or-beginning-search as a zle widget
zle -N down-line-or-beginning-search # Register down-line-or-beginning-search as a zle widget

bindkey '^[[A' up-line-or-beginning-search    # Up arrow for history search
bindkey '^[[B' down-line-or-beginning-search  # Down arrow for history search
### End of search history with arrow keys

alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'

# Git integration in prompt
autoload -Uz vcs_info # Load version control info
precmd() { vcs_info } # Update vcs_info before each command
zstyle ':vcs_info:git:*' formats ' (%b)' # Format for git branch
setopt PROMPT_SUBST # Enable prompt string expansion

# commented line includes directory, second one doesn't
# PS1='%B%{$fg[cyan]%}%~%{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%} ➜ %b'
PS1='%B%{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%} ➜ %b'

source ~/.zshrc-config/aliases/aliases.zsh
source ~/.zshrc-config/envvars.zsh
source ~/.zshrc-config/etc.zsh

source ~/.zshrc-config/lib/git.zsh

# Plugins

source ~/.zshrc-config/plugins/git/git.plugin.zsh
# Must be installed last
[[ -f ~/.zshrc-config/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]] && \
  source ~/.zshrc-config/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# Must be installed last
[[ -f ~/.zshrc-config/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]] && \
  source ~/.zshrc-config/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Set the title of the terminal window to the current directory if using iterm2
if [ $ITERM_SESSION_ID ]; then
precmd() {
  echo -ne "\033]0;${PWD##*/}\007"
}
fi
