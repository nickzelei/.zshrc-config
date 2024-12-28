
# Terraform and Terragrunt
alias tff="terraform fmt --recursive"
alias tg="terragrunt"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias tgf="terragrunt hclfmt"
alias tfclean="rm -rf .terraform .terraform.lock.hcl backend.tf providers.tf"


function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}

# etc
alias av="aws-vault"
alias k="kubectl"

alias gmt="go mod tidy"

alias kctx='kubectx'
alias kctxstage='kubectx arn:aws:eks:us-west-2:997306413652:cluster/neosync-stage-2'
alias kctxprod='kubectx nucleus-prod-1'
alias kctxeuprod='kubectx neosync-prod-1-eu'

alias brewup='brew update && brew upgrade && brew autoremove && brew cleanup'

get_stage_tunnel() {
    INSTANCE_ID=$(aws-vault exec stage -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-stage" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec stage -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-stage-neosync.cffkzijt5nto.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5443" --target $INSTANCE_ID
}
alias stage_tunnel='get_stage_tunnel'

get_prod_tunnel() {
    INSTANCE_ID=$(aws-vault exec prod -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-prod" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec prod -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-prod-nucleus-one.cxmhfqug8ymr.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5444" --target $INSTANCE_ID
}
alias prod_tunnel='get_prod_tunnel'

# get_prod_tunnel_redis() {
#     INSTANCE_ID=$(aws-vault exec prod -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-prod" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
#     echo "Connecting to Jump Box: $INSTANCE_ID"
#     aws-vault exec prod -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="master.neosync-redis.jphk2x.usw2.cache.amazonaws.com",portNumber="6379",localPortNumber="6378" --target $INSTANCE_ID
# }
# alias prod_tunnel_redis='get_prod_tunnel_redis'

docker_rmi() {
    docker rmi -f $(docker images -aq)
}

# git
alias nzm="git fetch && git checkout master && git reset --hard origin/master"
alias nzmm="git fetch && git checkout main && git reset --hard origin/main"
alias devn="git fetch && git checkout develop/v0.5 && git reset --hard origin/develop/v0.5"
alias gmcsg="gcmsg" # I keep typoing this
alias gcsmg="gcmsg" # I keep typoing this too

# Neosync
alias n="neosync"

source ~/.zshrc-config/aliases/directories.zsh
