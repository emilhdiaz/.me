aws-get-account() {
  # Parse the environment variable into an associative array
  
  declare -A ACCOUNTS=();
  a=("${(@s/;/)AWS_ACCOUNTS}")

  for val in ${a}; do
    IFS='=' read profile account <<< ${val}
    #echo "${profile} => ${account}";
    ACCOUNTS[$profile]="$account";
  done

  # Locate the account number for the given AWS profile
  ACCOUNT=${ACCOUNTS[$AWS_PROFILE]}

  # If not found, query AWS caller identity
  if [[ -z "${ACCOUNT}" ]]; then

    #echo "Environment variable AWS_ACCOUNTS is not aware of this profile, looking up caller identity from AWS instead" 1>&2

    ACCOUNT=$(AWS_PROFILE=${AWS_PROFILE} aws sts get-caller-identity --output text --query 'Account' 2> /dev/null)
    success=$?

    if [[ "$success" -gt 0 ]]; then
      (>&2 echo "The AWS_PROFILE supplied is invalid")
      return 1;
    fi

    # cache for later use
    ACCOUNTS[$AWS_PROFILE]=${ACCOUNT}
   
    # flatten into a string
    declare -a _AWS_ACCOUNTS=()
    for profile account in ${(kv)ACCOUNTS}; do
      #echo "${profile} => ${account}";
      _AWS_ACCOUNTS+=("${profile}=${account}")
    done

    #echo ${ACCOUNTS[$AWS_PROFILE]}
    #echo $(IFS=';'; echo "${_AWS_ACCOUNTS}")

    # export to external environment
    export AWS_ACCOUNTS=$(IFS=';'; echo "${_AWS_ACCOUNTS}")
    #echo $AWS_ACCOUNTS

  fi

  echo ${ACCOUNTS[$AWS_PROFILE]}
}

aws-get-account2() {
: <<DOC
Looks up the AWS account associated with supplied AWS profile or defaults to the
current active AWS_PROFILE.
This function will cache lookups for faster responses in the future.
--------------------------------------------------------------------------------
DOC
  set +eu;
  local AWS_PROFILE=${1:-"${AWS_PROFILE}"}
  # Parse the environment variable into an associative array
  declare -A ACCOUNTS=();
  local a=("${(@s/;/)AWS_ACCOUNTS}")
  for val in ${a}; do
    IFS='=' read profile account <<< ${val}
    ACCOUNTS[$profile]="$account";
  done
  # Locate the account number for the given AWS_PROFILE
  local ACCOUNT=${ACCOUNTS["${AWS_PROFILE}"]}
  # If not found, query AWS caller identity
  if [[ -z "${ACCOUNT}" ]]; then
    log_warn "Environment variable AWS_ACCOUNTS is not aware of this profile, looking up caller identity from AWS instead"
    ACCOUNT=$(AWS_PROFILE="${AWS_PROFILE}" aws sts get-caller-identity --output text --query 'Account' 2> /dev/null)
    if [ -z "${ACCOUNT}" ]; then
      log_error "An AWS account for AWS_PROFILE=${AWS_PROFILE} could not be found!" && return 1
    fi
    # cache for later use
    ACCOUNTS["${AWS_PROFILE}"]=${ACCOUNT}
    # flatten into a string
    declare -a _AWS_ACCOUNTS=()
    for profile account in ${(kv)ACCOUNTS}; do
      _AWS_ACCOUNTS+=("${profile}=${account}")
    done
    # export to external environment
    export AWS_ACCOUNTS=$(IFS=';'; echo "${_AWS_ACCOUNTS}")
  fi
  echo ${ACCOUNTS["${AWS_PROFILE}"]}
  set -eu;
  return 0
}

aws-kubectl() {
  aws eks update-kubeconfig --name ${LABEL}

  if [[ $? -ne 0 ]]; then
    (>&2 echo "Please make sure you've set the LABEL environment variable correctly!")
    return 1
  fi

  kubectl $@
}

aws-helm() {
  aws eks update-kubeconfig --name ${LABEL}

  if [[ $? -ne 0 ]]; then
    (>&2 echo "Please make sure you've set the LABEL environment variable correctly!")
    return 1
  fi

  helm $@
}
