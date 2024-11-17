
# autojump
[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

# gcp
# source $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc
# source $HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc

# pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
