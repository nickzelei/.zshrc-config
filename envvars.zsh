# Go
export GOPRIVATE=github.com/nucleuscloud/*
export PATH="$PATH:$HOME/go/bin"
#export GOBIN="$PWD/bin"
#export PATH="$PATH:$GOBIN"

# Neosync
export PATH="$PATH:$HOME/code/nucleus/neosync/cli/bin"

# kctxpatch
export PATH="$PATH:$HOME/code/personal/kctxpatch/bin"

# AWS
export AWS_DEFAULT_REGION=us-west-2
export AWS_PAGER=""

# openssl
export PATH="$HOMEBREW_PREFIX/opt/openssl@3/bin:$PATH"

#volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# postgresql
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
