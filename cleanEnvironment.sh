#!/bin/bash

main(){
  printf '\n-----'
  printf '\nStopping any running containers.'
  stop_containers
  printf '\nRemoving any stopped and running containers.'
  remove_containers
  printf '\nRemoving any images on the system.'
  remove_images
  printf '\nRemoving any conjur network on the system.'
  remove_network
  printf '\nRemoving any conjur volume on the system.'
  remove_volume
  printf '\nRemove pip and docker'
  remove_docker
  printf '\nRemove Weavescope'
  remove_weavescope
  printf '\nRemove AWX directory'
  remove_awx
  printf '\n-----\n'
}

stop_containers(){
  docker container stop $(docker container ls -aq) &> /dev/null
}

remove_containers(){
  docker container rm $(docker container ls -aq) &> /dev/null
}

remove_images(){
  docker image rm -f $(docker image ls -aq) &> /dev/null
}

remove_network(){
  docker network rm conjur &> /dev/null
}

remove_volume(){
  docker volume rm conjur_cert &> /dev/null
  docker volume rm jenkins_api &> /dev/null
}

remove_docker(){
  pip uninstall docker -y &> /dev/null
  pip uninstall docker-py -y &> /dev/null
  pip uninstall docker-pycreds -y &> /dev/null
  pip uninstall pip -y &> /dev/null
  yum remove docker -y &> /dev/null
} 

remove_weavescope(){
  rm -f /usr/local/bin/scope &> /dev/null
}

remove_awx(){
  rm -Rf /opt/awx
}
main
