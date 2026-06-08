
# zoxide (smarter cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# fzf (fuzzy finder) — rebinds Ctrl-R history search, Ctrl-T file paste, Alt-C cd
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi
