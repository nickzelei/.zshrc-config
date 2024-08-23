
# Terraform and Terragrunt
alias tff="terraform fmt --recursive"
alias tg="terragrunt"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias tgf="terragrunt hclfmt"

function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}

# etc
alias av="aws-vault"
alias k="kubectl"
alias avstage="av exec stage-from-nick --"
alias avprod="av exec prod-from-nick --"
alias avshared="av exec shared-from-nick --"

# alias mgmtlogs="kubectl logs deployment/mgmt-api user-container-grpc -n nucleus"
alias npods="k get pods -nnucleus"
alias gmt="go mod tidy"
# alias customersvcs='kubectl get serviceaccount -l "api.usenucleus.cloud/service=customer-service" --all-namespaces'
# alias nat='cat ~/.nucleus/auth.yaml | yq ".accessToken"'
alias kctx='kubectx'
alias kctxstage='kubectx nucleus-stage-1'
alias kctxprod='kubectx nucleus-prod-1'
# alias kctxacme='kubectx arn:aws:eks:us-west-2:911593346794:cluster/acme2'
alias kctxdev='kubectx kind-nuc-dev'

# tilt
alias tu='kubectx kind-nuc-dev && aws-vault exec dev-nick-from-nick -- tilt up'
alias td='kubectx kind-nuc-dev && tilt down'

alias brewup='brew update && brew upgrade && brew autoremove && brew cleanup'

get_stage_tunnel() {
    INSTANCE_ID=$(aws-vault exec stage -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-stage" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec stage -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-stage-neosync.cffkzijt5nto.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5443" --target $INSTANCE_ID
}
alias stage_tunnel='get_stage_tunnel'
alias stage_tunnel2='get_stage_tunnel'

get_prod_tunnel() {
    INSTANCE_ID=$(aws-vault exec prod -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-prod" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec prod -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-prod-nucleus-one.cxmhfqug8ymr.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5444" --target $INSTANCE_ID
}
alias prod_tunnel='get_prod_tunnel'

get_prod_tunnel_redis() {
    INSTANCE_ID=$(aws-vault exec prod -- aws ec2 describe-instances --filters "Name=tag:Name,Values=ssm-bastion-lt-prod" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec prod -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="master.neosync-redis.jphk2x.usw2.cache.amazonaws.com",portNumber="6379",localPortNumber="6378" --target $INSTANCE_ID
}
alias prod_tunnel_redis='get_prod_tunnel_redis'

docker_rmi() {
    docker rmi -f $(docker images -aq)
}
# alias stage_tunnel='aws-vault exec stage-from-nick -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-stage-nucleus.cluster-cffkzijt5nto.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5433" --target $1'

# dev_role() {
#     echo "$NUCLEUS_DEV_ROLE_ARN" | pbcopy
# }

# setup_dev_cluster() {
#     aws-vault exec dev-nick-from-nick -- aws eks update-kubeconfig --region us-west-2 --name $1
# }

# git
alias nzm="git fetch && git checkout master && git reset --hard origin/master"
alias nzmm="git fetch && git checkout main && git reset --hard origin/main"
alias gmcsg="gcmsg" # I keep typoing this
alias gcsmg="gcmsg" # I keep typoing this too

# Neosync
alias n="neosync"
