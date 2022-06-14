#!/bin/bash
set -x

if [ ! ${ARCH} ]; then
  MACHINE=`uname -m`
  if [ "${MACHINE}" == "x86_64" ]; then
    ARCH=amd64
  elif [ "${MACHINE}" == "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown machine" && exit 1
  fi
fi

[ $CI_BUILD_TOKEN ] && {
  docker login -u gitlab-ci-token    -p $CI_BUILD_TOKEN $CI_REGISTRY
} || {
  IMAGE_NAME=$(git remote get-url origin |awk -F '/' '{print $NF}'|sed -e 's#\.git##g')
  CI_REGISTRY_IMAGE="$IMAGE_NAME"
  [ $CI_COMMIT_REF_NAME ] || CI_COMMIT_REF_NAME=$(git rev-parse --abbrev-ref HEAD)
}
IMAGE=$CI_REGISTRY_IMAGE/$ARCH:$CI_COMMIT_REF_NAME

rm -rf .git

sed -i "s/ARCH/$ARCH/g" Dockerfile

docker build --network host -t $IMAGE -f Dockerfile .

[ $CI_BUILD_TOKEN ] && docker push $IMAGE

exit 0
