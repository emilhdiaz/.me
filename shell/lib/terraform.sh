tf_workspace_select() {
  ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account' 2>/dev/null)
  if [[ $? -ne 0 ]] || [[ -z "${ACCOUNT}" ]]; then
    (echo >&2 "An AWS account could not be found for your current credential chain!")
    return 1
  fi

  if [[ -z "${LABEL}" ]]; then
    (echo >&2 "Please make sure you've set the LABEL environment variable correctly!")
    return 1
  fi

  terraform workspace select ${ACCOUNT}::${LABEL} #&> /dev/null

  if [[ $? != 0 ]]; then
    terraform workspace new ${ACCOUNT}::${LABEL} #&> /dev/null;
  fi

  echo "Workspace ${ACCOUNT}::${LABEL} activated"
}

tf_update_all() {
  DIR=$1 && shift
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && terraform get -update" \; # 2> /dev/null;
}

tf_workspace() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      terraform workspace $@
  )
}

tf_init() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      terraform init -reconfigure -get -backend-config ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_update() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      terraform init -reconfigure -get -upgrade -backend-config ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_plan() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform plan -var-file ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_apply() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform apply -var-file ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_import() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform import -var-file ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_destroy() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform destroy -var-file ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_taint() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform taint -var-file ../../../vars/${LABEL}-backend.tfvars "$@"
  )
}

tf_state() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform state "$@"
  )
}

tf_output() {
  DIR=$1 && shift
  (
    cd ${DIR} &&
      tf_workspace_select &&
      terraform output "$@"
  )
}
