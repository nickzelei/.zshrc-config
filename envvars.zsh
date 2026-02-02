# Go
# export GOPRIVATE=github.com/nucleuscloud/*
export PATH="$PATH:$HOME/go/bin"

# AWS
export AWS_DEFAULT_REGION=us-west-2
export AWS_PAGER=""

# openssl
export PATH="$HOMEBREW_PREFIX/opt/openssl@3/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

export LESS="-R" # adding -X will prevent the pager from clearing

# Sets up GPG
export GPG_TTY=$(tty)
