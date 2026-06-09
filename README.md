# ZSHRC Config

To configure, simply source `setup.zsh` in your `.zshrc` file, e.g.:

```console
source ~/.zshrc-config/setup.zsh
```

The repo can live anywhere — `setup.zsh` derives its own location and sources
the sub files relative to it (exposed as `$ZSHRC_CONFIG_DIR`). Just point the
`source` line in your `.zshrc` at wherever you cloned it.

## Motivation

I previously used omz, but I found it was slowing down my shell init.
This contains a heavily paired down version of only what I've needed over the years to keep it really simple and easy to move around.

## Plugins

To install all plugins, run `git clone --recurse-submodules <url>` during the initial clone.
If the repo has already been cloned, install them by invoking the following:

Some must be installed via brew:

```console
brew bundle
```

```console
git submodule init && git submodule update
```

All of the submodules are conditionally sourced in `setup.zsh`.

- `omz git`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `autojump` - Expects to be installed from homebrew (listed in the Brewfile).

### Updating Submodules

```console
git submodule update --remote --merge
```
