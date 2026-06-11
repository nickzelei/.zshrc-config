# dotfiles

My personal config, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Currently tracks my zsh setup; structured so more tools can be added later as
their own stow packages.

## Install

Clone anywhere except `~/.config/zsh` itself (that path becomes a symlink into
the repo). `~/dotfiles` is the convention and matches where Ona clones it:

```console
git clone --recurse-submodules <url> ~/dotfiles
cd ~/dotfiles
make install   # brew deps + symlink + wire up ~/.zshrc
```

`make install` runs `brew bundle` then `./install.sh`. If you just want the
symlinks without touching brew, run `./install.sh` (or `make stow`) directly.

Then open a new shell (or `exec zsh`).

### How the linking works

Each top-level directory here is a [stow](https://www.gnu.org/software/stow/)
package whose contents mirror `$HOME`. The `zsh` package contains
`zsh/.config/zsh/...`, so stowing it creates:

```
~/.config/zsh -> ~/dotfiles/zsh/.config/zsh
```

`install.sh` does the stow (falling back to a plain `ln -s` on minimal images
where stow isn't installed) and appends a guarded source line to `~/.zshrc`:

```console
[[ -f ~/.config/zsh/setup.zsh ]] && source ~/.config/zsh/setup.zsh
```

The `[[ -f ... ]]` guard means your shell still starts cleanly if the repo is
ever moved or removed, instead of erroring on every prompt.

## Ona

Ona [supports dotfiles](https://ona.com/docs/ona/configuration/dotfiles/overview):
point it at this repo's Git URL. On environment startup Ona clones it to
`~/dotfiles` and runs `install.sh` (the first script it finds, ahead of
`bootstrap`/`setup`). The script is non-interactive and self-contained, so it
works in Ona's no-TTY startup without hanging. Brew deps are skipped there —
`install.sh` only does the symlink + submodules + `~/.zshrc` wiring, and the
config degrades gracefully when tools like `zoxide`/`fzf` aren't present.

## Motivation

I previously used oh-my-zsh, but found it was slowing down my shell init.
This is a heavily pared-down setup with only what I've needed over the years —
simple, fast, and easy to move between machines.

## Layout

Repo root holds tooling that is *not* symlinked into `$HOME`:

- `install.sh` — symlinks packages into `$HOME` and wires `~/.zshrc` (idempotent).
- `Brewfile` — brew deps (`fzf`, `fd`, `ripgrep`, `stow`, `zoxide`, `mise`, …).
- `Makefile` — maintenance commands; run `make` to list them.
- `bench/` — init benchmark script and its results log.

Stow packages (their contents get symlinked into `$HOME`):

- `zsh/.config/zsh/` — the whole zsh config, symlinked to `~/.config/zsh`:
  - `setup.zsh` — entrypoint; prompt, history, keybindings, and sources the rest.
  - `envvars.zsh` — environment variables and `$PATH` setup.
  - `aliases/` — aliases and directory shortcuts.
  - `etc.zsh` — wires up CLI tools (`zoxide`, `mise`, `fzf`).
  - `lib/git.zsh` — git helper functions.
  - `mise/config.toml` — global [mise](https://mise.jdx.dev) tool config, pointed
    at via `MISE_GLOBAL_CONFIG_FILE` so the tool baseline is tracked in the repo.
  - `plugins/` — the vendored `git` plugin plus zsh plugin submodules.

## Commands

Run `make` (no args) in the repo to see everything:

```console
make          # list commands
make install  # brew deps + symlink + wire up ~/.zshrc
make stow     # symlink + wire up ~/.zshrc (no brew)
make bench    # benchmark zsh init time, log to bench/results.md
make profile  # per-component init profile (what's slow)
make update   # update plugin submodules
```

## Plugins

`zsh-autosuggestions` and `zsh-syntax-highlighting` are git submodules under
`zsh/.config/zsh/plugins/`, conditionally sourced in `setup.zsh`. `install.sh`
checks them out for you. If you cloned without `--recurse-submodules`:

```console
git submodule update --init --recursive
```

To update them to their latest upstream:

```console
make update
```

`fzf-tab` is installed via Homebrew (in the `Brewfile`) and sourced from there.
