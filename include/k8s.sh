k8s-switch-context() {
  : <<DOC
Switches the current kubectl context
--------------------------------------------------------------------------------
CONTEXT  The name of valid EKS cluster name
DOC
  set +eu
  local LABEL=${1:-"${LABEL}"}
  local KUBECONFIG=${2:-"${KUBECONFIG}"}
  local AWS_ACCOUNT=${3:-"${AWS_ACCOUNT}"}
  local AWS_DEFAULT_REGION=${4:-"${AWS_DEFAULT_REGION}"}
  local CONTEXT="arn:aws:eks:${AWS_DEFAULT_REGION}:${AWS_ACCOUNT}:cluster/${LABEL}"
  # current context already matched target context, nothing to do
  if [ "$(kubectl config current-context)" = "${CONTEXT}" ]; then
    return 0
  fi
  # switch the kubeconfig context if exists
  kubectl config use-context ${CONTEXT} --kubeconfig ${KUBECONFIG} &>/dev/null
  # if context was not found, attempt to grab it from EKS
  if [[ $? -ne 0 ]]; then
    aws eks update-kubeconfig --name ${LABEL} --kubeconfig ${KUBECONFIG}
  fi
  # current context already matched target context, nothing to do
  if [ "$(kubectl config current-context)" != "${CONTEXT}" ]; then
    log_error "Could not switch to the target KUBECONFIG context: ${CONTEXT}" && return 1
  fi
  # init/upgrade Helm's Tiller version
  helm init --upgrade --kubeconfig ${KUBECONFIG}
  set -eu
  return 0
}

k8s-dashboard() {
  aws-iam-authenticator token -i $LABEL | jq -r .status.token | pbcopy
  kubectl proxy
}
