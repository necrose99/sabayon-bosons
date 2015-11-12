#!/bin/bash
set -o nounset
set -o errexit


mkdir -p ~/.ssh/ || true
echo "$DEPLOY_PRIVKEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
rsync -avp -e "ssh -p $DEPLOY_PORT -i ~/.ssh/id_rsa" $CIRCLECI_ARTIFACTS/* $DEPLOY_SERVER
