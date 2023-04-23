
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
alias n="nucleus"
alias apilocal="make build && avstage ./bin/nucleus-api --kube-config-path /Users/nick/.kube/config-local"
get_kube_dash_token() {
  kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
}
get_kaili_token() {
    kubectl get secret -n istio-system $(kubectl get sa kiali-service-account -n istio-system -o "jsonpath={.secrets[0].name}") -o jsonpath={.data.token} | base64 -d
}
# switch_kube_ctx() {
#     kubectl config use-context $1
# }
alias kubedashtoken='get_kube_dash_token'
alias kailitoken='get_kaili_token'
alias operatorlogs="kubectl logs deployment/nucleus-operator-controller-manager manager -n nucleus-operator-system"
alias operatorlogs2="kubectl logs deployment/nucleus-operator-controller-manager manager -n nucleus"
alias apilogs="kubectl logs -n nucleus-api deployment/nucleus-api user-container-grpc"
alias mgmtlogs="kubectl logs deployment/mgmt-api user-container-grpc -n nucleus"
alias npods="k get pods -nnucleus"
alias gmt="go mod tidy"
alias customersvcs='kubectl get serviceaccount -l "api.usenucleus.cloud/service=customer-service" --all-namespaces'
alias nat='cat ~/.nucleus/auth.yaml | yq ".accessToken"'
# alias kctx='kubectl config current-context'
# alias kctxstage='switch_kube_ctx nucleus-stage-1'
# alias kctxprod='switch_kube_ctx nucleus-prod-1'
# alias kctxacme='switch_kube_ctx arn:aws:eks:us-west-2:911593346794:cluster/acme2'
# alias kctxdev='switch_kube_ctx kind-nuc-dev'
alias kctx='kubectx'
alias kctxstage='kubectx nucleus-stage-1'
alias kctxprod='kubectx nucleus-prod-1'
alias kctxacme='kubectx arn:aws:eks:us-west-2:911593346794:cluster/acme2'
alias kctxdev='kubectx kind-nuc-dev'

alias brewup='brew update && brew upgrade && brew autoremove && brew cleanup'

get_stage_tunnel() {
    INSTANCE_ID=$(aws-vault exec stage-from-nick -- aws ec2 describe-instances --filter "Name=tag:Name,Values=ssm-bastion-lt-stage" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec stage-from-nick -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-stage-nucleus.cluster-cffkzijt5nto.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5433" --target $INSTANCE_ID
}
alias stage_tunnel='get_stage_tunnel'

get_prod_tunnel() {
    INSTANCE_ID=$(aws-vault exec prod-from-nick -- aws ec2 describe-instances --filter "Name=tag:Name,Values=ssm-bastion-lt-prod" --query "Reservations[0].Instances[0].InstanceId" --output text)
    echo "Connecting to Jump Box: $INSTANCE_ID"
    aws-vault exec prod-from-nick -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-prod-nucleus-one.cxmhfqug8ymr.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5434" --target $INSTANCE_ID
}
alias prod_tunnel='get_prod_tunnel'

docker_rmi() {
    docker rmi -f $(docker images -aq)
}
# alias stage_tunnel='aws-vault exec stage-from-nick -- aws ssm start-session --region us-west-2 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="nucleus-stage-nucleus.cluster-cffkzijt5nto.us-west-2.rds.amazonaws.com",portNumber="5432",localPortNumber="5433" --target $1'
