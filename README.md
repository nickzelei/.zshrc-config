# ZSHRC Config

To configure, simply source `setup.zsh` in your `.zshrc` file, e.g.:

```console
source ~/.zshrc-config/setup.zsh
```

The repo can live anywhere — `setup.zsh` derives its own location and sources
the sub files relative to it (exposed as `$ZSHRC_CONFIG_DIR`). Just point the
`source` line in your `.zshrc` at wherever you cloned it.

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
