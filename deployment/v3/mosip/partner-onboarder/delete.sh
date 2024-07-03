#!/bin/bash
# Uninstalls partner-onboarder helm
## Usage: ./delete.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

function deleting_onboarder() {
  NS=onboarder
  while true; do
      read -p "Are you sure you want to delete all partner-onboarder ?(Y/n) " yn
      if [ $yn = "Y" ]; then
        echo Deleting partner-onboarder helm
        helm -n $NS delete partner-onboarder
        break
      fi
  done
  
  echo "   === SQL CLEANUP ==="
  echo "DELETE FROM auth_policy WHERE name = 'mpolicy-default-mimotokeybinding';"
  echo "DELETE FROM auth_policy WHERE name = 'mpolicy-default-resident-oidc';"
  echo "DELETE FROM auth_policy WHERE name = 'mpolicy-default-demo-oidc Policy';"
  echo "DELETE FROM auth_policy WHERE name = 'mpolicy-default-esignet Policy';"
  
  echo "DELETE FROM auth_policy_h WHERE name = 'mpolicy-default-mimotokeybinding';"
  echo "DELETE FROM auth_policy_h WHERE name = 'mpolicy-default-resident-oidc';"
  echo "DELETE FROM auth_policy_h WHERE name = 'mpolicy-default-demo-oidc Policy';"
  echo "DELETE FROM auth_policy_h WHERE name = 'mpolicy-default-esignet Policy';"
  
  echo "DELETE FROM partner WHERE id = 'mpartner-default-resident-oidc';"
  echo "DELETE FROM partner WHERE id = 'mpartner-default-demo-oidc';"
  echo "DELETE FROM partner WHERE id = 'mpartner-default-mimotokeybinding';"
  echo "DELETE FROM partner WHERE id = 'mpartner-default-esignet';"
  
  echo "DELETE FROM partner_h WHERE user_id = 'mpartner-default-resident-oidc';"
  echo "DELETE FROM partner_h WHERE user_id = 'mpartner-default-demo-oidc';"
  echo "DELETE FROM partner_h WHERE user_id = 'mpartner-default-mimotokeybinding';"
  echo "DELETE FROM partner_h WHERE user_id = 'mpartner-default-esignet';"
  
  echo "DELETE FROM policy_group WHERE user_id = 'mpartner-default-resident-oidc';"
  echo "DELETE FROM policy_group WHERE user_id = 'mpartner-default-demo-oidc';"
  echo "DELETE FROM policy_group WHERE user_id = 'mpartner-default-mimotokeybinding';"
  echo "DELETE FROM policy_group WHERE user_id = 'mpartner-default-esignet';"
  echo "   === SQL CLEANUP ==="
  
  return 0
}

# set commands for error handling.
set -e
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errtrace  # trace ERR through 'time command' and other functions
set -o pipefail  # trace ERR through pipes
deleting_onboarder   # calling function
