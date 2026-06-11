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
set -euo pipefail

# Repo root = the directory containing this script, resolved so it works
# wherever the repo is cloned (~/dotfiles on Ona, anywhere on your laptop).
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

# Plugins are git submodules; the zsh config sources them, so make sure they're
# checked out. Skips cleanly if the repo was cloned with --recurse-submodules.
if [ -f .gitmodules ] && command -v git >/dev/null 2>&1; then
  git submodule update --init --recursive
fi

# Symlink the `zsh` stow package into $HOME, i.e. create the link
#   ~/.config/zsh -> $REPO_DIR/zsh/.config/zsh
# Prefer GNU Stow; fall back to a plain symlink so this still works on minimal
# images (like an Ona container) where stow isn't installed.
mkdir -p "$HOME/.config"

# Guard the footgun: if ~/.config/zsh already exists as a real directory (not a
# symlink we own), bail loudly instead of nesting a link inside it.
target="$HOME/.config/zsh"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  echo "error: $target exists and is not a symlink." >&2
  echo "       Move or remove it, then re-run. (If this is the old in-place" >&2
  echo "       checkout of this repo, that's expected during migration.)" >&2
  exit 1
fi

if command -v stow >/dev/null 2>&1; then
  stow --restow --target="$HOME" --dir="$REPO_DIR" zsh
else
  ln -sfn "$REPO_DIR/zsh/.config/zsh" "$target"
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
