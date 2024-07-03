#!/bin/bash

# Installs MOSIP services in correct order
## Usage: ./install-all.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

function installing_all() {
  ROOT_DIR=`pwd`/../ 

  declare -a module=("conf-secrets"
                     "config-server"  # <-- Ho aggiunto `mosip-signup-host: signup.prgs-project.com` alla configmap default/global
                     "artifactory"
                     "keymanager"  
                     "websub"       
                     "mock-smtp"          
                     "kernel"               
                     "masterdata-loader"    
                     "biosdk"             
                     "packetmanager"      
                     "datashare"      
                     "prereg"         
                     "idrepo"         
                     "pms"          # <-- mi da not found quando vado a daprire il sito pmp=ui
                     "mock-abis"    
                     "mock-mv"      
                     "regproc"      
                     "admin"      
                     "ida"          
                     "print"              
                     "partner-onboarder"    # <-- mimoto ok, gli altri job sono mezzi in errore in realtà 
                     "mosip-file-server"
                     "resident"             
                     "regclient"        # <-- funziona solo con OpsnEELv1.1.1q: `brew install openssl@1.1 & export PATH="$(brew --prefix)/opt/openssl@1.1/bin:$PATH"` 
                     )

  echo Installing MOSIP services

  for i in "${module[@]}"
  do
    cd $ROOT_DIR/"$i"
    sed -i 's/\r$//' install.sh
    ./install.sh
  done

  echo All MOSIP services deployed sucessfully.
  return 0
}

# set commands for error handling.
set -e
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errtrace  # trace ERR through 'time command' and other functions
set -o pipefail  # trace ERR through pipes
installing_all   # calling function
