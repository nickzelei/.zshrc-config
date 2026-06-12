#!/usr/bin/env bash
#
# Dotfiles installer. Symlinks the tracked config into $HOME and wires it into
# ~/.zshrc. Idempotent — safe to re-run.
#
# Two consumers:
#   - Your laptop: run `./install.sh` (or `make install` to also pull brew deps).
#   - Ona: clones this repo to ~/dotfiles and runs this script automatically on
#     environment startup. Ona runs it NON-INTERACTIVELY with no TTY, so this
#     script never prompts and degrades gracefully when tools are missing.
#     See https://ona.com/docs/ona/configuration/dotfiles/overview
#
# Every directory under packages/ is a stow package whose contents mirror $HOME
# (e.g. packages/zsh/.config/zsh -> ~/.config/zsh). Adding a tool is just
# `mkdir packages/<tool>/...` — this script discovers it automatically, no edit
# needed here.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$REPO_DIR/packages"
cd "$REPO_DIR"

# Plugins are git submodules; the zsh config sources them, so make sure they're
# checked out. Skips cleanly if the repo was cloned with --recurse-submodules.
if [ -f .gitmodules ] && command -v git >/dev/null 2>&1; then
  git submodule update --init --recursive
fi

mkdir -p "$HOME/.config"

# If ~/.config/zsh already exists as a real directory (not a symlink), bail
# loudly instead of nesting a link inside it. A stale symlink (ours, maybe
# pointing at an old path) is fine — we drop it below before relinking.
zdir="$HOME/.config/zsh"
if [ -e "$zdir" ] && [ ! -L "$zdir" ]; then
  echo "error: $zdir exists and is not a symlink. Move or remove it, then re-run." >&2
  exit 1
fi
[ -L "$zdir" ] && rm -f "$zdir"

if command -v stow >/dev/null 2>&1; then
  # Discover and stow every package under packages/ — no hardcoded list.
  names=()
  for p in "$PKG_DIR"/*/; do names+=("$(basename "$p")"); done
  stow --restow --dir="$PKG_DIR" --target="$HOME" "${names[@]}"
else
  # No stow (e.g. a minimal Ona image). We deliberately DON'T try to install it
  # — that's the fragile, cross-distro part. Instead guarantee the one thing
  # that must always work: a usable shell. Link the zsh package directly and
  # skip the rest with a notice.
  echo "stow not found — linking the zsh package only (others need stow)." >&2
  ln -sfn "$PKG_DIR/zsh/.config/zsh" "$zdir"
  for p in "$PKG_DIR"/*/; do
    name="$(basename "$p")"
    [ "$name" = zsh ] || echo "  skipped (needs stow): $name" >&2
  done
fi

# Wire the config into ~/.zshrc (guarded so the shell still starts if the repo
# is ever moved or removed). Idempotent: only appends if not already present.
zshrc="$HOME/.zshrc"
if [ ! -f "$zshrc" ] || ! grep -qF 'config/zsh/setup.zsh' "$zshrc"; then
  printf '\n[[ -f ~/.config/zsh/setup.zsh ]] && source ~/.config/zsh/setup.zsh\n' >> "$zshrc"
  echo "Added source line to $zshrc."
else
  echo "$zshrc already sources the config; left it alone."
fi

echo "Done. Open a new shell (or 'exec zsh') to pick up the config."
