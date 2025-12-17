
# autojump
[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

# gcp
# source $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc
# source $HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
