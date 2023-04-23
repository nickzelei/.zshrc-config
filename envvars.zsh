
# git
alias nzm="git fetch && git checkout master && git reset --hard origin/master"
alias nzmm="git fetch && git checkout main && git reset --hard origin/main"

# Go
export GOPRIVATE=github.com/nucleuscloud/*
export PATH="$PATH:$HOME/go/bin"
#export GOBIN="$PWD/bin"
#export PATH="$PATH:$GOBIN"

export PATH="$PATH:$HOME/code/nucleus/nucleus-dev/cli/bin"

# AWS
export AWS_REGION=us-west-2
export AWS_PAGER=""

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/nick/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nick/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/nick/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nick/google-cloud-sdk/completion.zsh.inc'; fi

# openssl
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

#volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export NUCLEUS_AWS_VAULT_PROFILE='dev-nick-from-nick'
export NUCLEUS_DEV_DNS_ZONE_ID='Z03366151CZTEUE71SSLS'
export NUCLEUS_DEV_DOMAIN_PREFIX='nick'
export NUCLEUS_DEV_EVENTS_TOPIC_ARN='arn:aws:sns:us-west-2:295461250191:mgmt-api-events'
export NUCLEUS_DEV_EVENTS_QUEUE_URL='https://sqs.us-west-2.amazonaws.com/295461250191/mgmt-api-events-queue'
export NUCLEUS_DEV_NOTIFICATIONS_QUEUE_URL="https://sqs.us-west-2.amazonaws.com/295461250191/mgmt-api-notifications-queue"
