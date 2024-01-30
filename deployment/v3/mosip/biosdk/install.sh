#!/bin/bash
# Installs BioSDK
## Usage: ./install.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

NS=biosdk
CHART_VERSION=12.0.1-B3

echo Create $NS namespace
kubectl create ns $NS

function installing_biosdk() {
  echo Istio label
  kubectl label ns $NS istio-injection=enabled --overwrite
  helm repo update

  echo Installing Biosdk server
  helm -n $NS install biosdk-service mosip/biosdk-service --set image.repository=mosipid/biosdk-server --set image.tag=1.2.0.1-B3 -f values.yaml --version $CHART_VERSION
  echo Biosdk service installed sucessfully.
  return 0
}

# set commands for error handling.
set -e
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errtrace  # trace ERR through 'time command' and other functions
set -o pipefail  # trace ERR through pipes
installing_biosdk   # calling function