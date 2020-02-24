#/bin/bash

# Clear screen
clear

# Setup environment
DOCKER=$(which docker 2>/dev/null)
MOUNT=$(which mount 2>/dev/null)
TMP='/tmp'
IMAGE="debian"
CONTAINERNAME="ContainerName"
CONTAINERSHAREDIR="/mnt/shareDir"
HOSTSHAREDIR="/mnt/shareDir"
CONTAINERHOSTNAME="DebianContainer"

# Verify binaries exist
MISSING=''
[ ! -e "$DOCKER" ] && MISSING+='docker, '
[ ! -e "$MOUNT" ] && MISSING+='mount, '
if [ -n "$MISSING" ]; then
  echo "Error: cannot find the following binaries: ${MISSING%%, }"
  exit
fi

echo "=========================================================="
echo "Please pick the docker image to use. Eks:			"
echo "								"
echo "debian	Distribution entirely of free and open software."
echo "								"
echo "alpine	A minimal Docker image based on Alpine Linux	"
echo "	with a complete package index and only 5 MB	"
echo "=========================================================="
read -p 'Container name: ' IMAGE



echo "=========================================================="
echo "Pull down the $IMAGE docker image.			"
echo ":~# docker pull $IMAGE					"
echo "=========================================================="
echo "Do you wish to install this program?"
read -p "Yes / No : " answere

if [ "$answere" = yes ] || [ "$answere" = YES ] || [ "$answere" = Y ] || [ "$answere" = y ] ; then
    echo "Yes"
	docker pull $IMAGE
else
    echo "No"
fi

#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) docker pull debian; break;;
#        No ) exit;;
#    esac
#done

echo "=========================================================="
echo "Please supply Container name. eks mydebian		"
echo "=========================================================="
read -p 'Container name: ' CONTAINERNAME

echo "=========================================================="
echo "Please supply Container hostname. eks debianPluss		"
echo "=========================================================="
read -p 'Hostname: ' CONTAINERHOSTNAME

echo "=========================================================="
echo "Please supply Container share directory. eks /mnt/share/  "
echo "=========================================================="
read -p 'Container share dir: ' CONTAINERSHAREDIR

echo "=========================================================="
echo "Please supply host share directory. eks /mnt/share/   	"
echo "=========================================================="
read -p 'Host share dir: ' HOSTSHAREDIR


echo "=========================================================="
echo "Make a new Container with thise setups?                   "
echo "Container name: $CONTAINERNAME"
echo "Container hostname: $CONTAINERHOSTNAME"
echo "Container share dir: $CONTAINERSHAREDIR"
echo "Host share dir: $HOSTSHAREDIR"


echo ":~# docker pull $IMAGE                                    "
echo "=========================================================="
echo "Do you wish to install this program?"
echo "docker run -i -t --name $CONTAINERNAME --hostname $CONTAINERHOSTNAME  -v $CONTAINERSHAREDIR:$HOSTSHAREDIR" $IMAGE /bin/sh

read -p "Yes / No : " answere

if [ "$answere" = yes ] || [ "$answere" = YES ] || [ "$answere" = Y ] || [ "$answere" = y ] ; then
    echo "Yes"
        docker run -i -t --name $CONTAINERNAME --hostname $CONTAINERHOSTNAME  -v $CONTAINERSHAREDIR:$HOSTSHAREDIR $IMAGE /bin/sh
else
    echo "No"
fi



#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) docker run -i -t --name $CONTAINERNAME --hostname $CONTAINERHOSTNAME  -v $CONTAINERSHAREDIR:$HOSTSHAREDIR debian /bin/bash ; break;;
#	No ) exit;;
#    esac
#done

#  docker exec -u 0 -it mydebian bash
# docker run -i -t --volume /home/docker/container-data-share/:/home/container-data-share --name mydebian debian /bin/bash
# docker run -d -P --name mydebian -v /home/docker/container-data-share:/data debian
