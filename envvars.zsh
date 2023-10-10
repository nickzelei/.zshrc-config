# Go
export GOPRIVATE=github.com/nucleuscloud/*
export PATH="$PATH:$HOME/go/bin"
#export GOBIN="$PWD/bin"
#export PATH="$PATH:$GOBIN"

# Nucleus
export PATH="$PATH:$HOME/code/nucleus/nucleus-dev/cli/bin"
export NUCLEUS_AWS_VAULT_PROFILE='dev-nick-from-nick'
export NUCLEUS_DEV_DNS_ZONE_ID='Z03366151CZTEUE71SSLS'
export NUCLEUS_DEV_DOMAIN_PREFIX='nick'
export NUCLEUS_DEV_EVENTS_TOPIC_ARN='arn:aws:sns:us-west-2:295461250191:mgmt-api-events'
export NUCLEUS_DEV_EVENTS_QUEUE_URL='https://sqs.us-west-2.amazonaws.com/295461250191/mgmt-api-events-queue'
export NUCLEUS_DEV_NOTIFICATIONS_QUEUE_URL="https://sqs.us-west-2.amazonaws.com/295461250191/mgmt-api-notifications-queue"
export NUCLEUS_DEV_ROLE_ARN='arn:aws:iam::295461250191:role/allow-full-access-from-other-accounts'


# Neosync
export PATH="$PATH:$HOME/code/nucleus/neosync/cli/bin"

# kctxpatch
export PATH="$PATH:$HOME/code/personal/kctxpatch/bin"

# AWS
export AWS_REGION=us-west-2
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
