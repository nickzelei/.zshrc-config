# ZSHRC Config

To configure, simply source `setup.zsh` in your `.zshrc` file.

## Plugins

To install all plugins, run `git clone --recurse-submodules <url>` during the initial clone.
If the repo has already been cloned, install them by invoking the following:

```console
git submodule init && git submodule update
```

All of the submodules are conditionally sourced in `setup.zsh`.

- `omz git`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `autojump` (needs to be installed manually from <https://github.com/wting/autojump>) - Expects to be installed from homebrew.

### Updating Submodules

```console
git submodule update --remote --merge
```