# zsh config

Clone the repo, then source `setup.zsh` from your `.zshrc`. The recommended
location is `~/.config/zsh` (the XDG convention for zsh config):

```console
git clone --recurse-submodules <url> ~/.config/zsh
```

Then wire it into your `~/.zshrc`. Either run `make link` (idempotent — it
appends the line below, pointing at wherever the repo actually lives), or add it
by hand:

```console
[[ -f ~/.config/zsh/setup.zsh ]] && source ~/.config/zsh/setup.zsh
```

The `[[ -f ... ]]` guard means your shell still starts cleanly if the repo is
ever moved or removed, instead of erroring on every prompt.

The repo can live anywhere, though — `setup.zsh` derives its own location and
sources the sub files relative to it (exposed as `$ZSHRC_CONFIG_DIR`). Just
point the `source` line in your `.zshrc` at wherever you cloned it.

## Motivation

I previously used oh-my-zsh, but found it was slowing down my shell init.
This is a heavily pared-down setup with only what I've needed over the years —
simple, fast, and easy to move between machines.

## Layout

- `setup.zsh` — entrypoint; prompt, history, keybindings, and sources the rest.
- `envvars.zsh` — environment variables and `$PATH` setup.
- `aliases/` — aliases and directory shortcuts.
- `etc.zsh` — wires up CLI tools (`zoxide`, `mise`, `fzf`).
- `lib/git.zsh` — git helper functions.
- `mise/config.toml` — global [mise](https://mise.jdx.dev) tool config, pointed
  at via `MISE_GLOBAL_CONFIG_FILE` so the tool baseline is tracked in the repo.
- `plugins/` — the vendored `git` plugin plus zsh plugin submodules.
- `bench/` — init benchmark script and its results log.
- `Makefile` — maintenance commands; run `make` to list them.

## Commands

Run `make` (no args) in the repo to see everything:

```console
make          # list commands
make link     # add a guarded source line to ~/.zshrc (idempotent)
make bench    # benchmark zsh init time, log to bench/results.md
make profile  # per-component init profile (what's slow)
make install  # brew deps + plugin submodules
make update   # update plugin submodules
```

## Setup

### Homebrew dependencies

CLI tools and apps are managed via the `Brewfile` (`fzf`, `fd`, `ripgrep`,
`fzf-tab`, `zoxide`, `mise`, `bat`, `lazygit`, `gh`, etc.):

```console
brew bundle
```

### Plugins

Submodules (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are conditionally
sourced in `setup.zsh`. Clone with submodules:

```console
git clone --recurse-submodules <url>
```

Or, if already cloned:

```console
git submodule init && git submodule update
```

`fzf-tab` is installed via Homebrew (in the `Brewfile`) and sourced from there.

#### Updating submodules

```console
git submodule update --remote --merge
```
