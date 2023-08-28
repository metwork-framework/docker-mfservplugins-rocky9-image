#!/bin/bash





#set -eu
set -x

case "${GITHUB_EVENT_NAME}" in
    repository_dispatch)
        BRANCH=${PAYLOAD_BRANCH}
        if [ -f .build_os ]; then
            OS_VERSION=`cat .build_os`
        else
            OS_VERSION=${PAYLOAD_OS}
        fi;;
    push)
        if [ -f .build_os ]; then
            OS_VERSION=`cat .build_os`
        else
            OS_VERSION=centos6
        fi
        case "${GITHUB_REF}" in
            refs/heads/*)
                BRANCH=${GITHUB_REF#refs/heads/};;
            *)
                BRANCH=null;
        esac;;
esac
if [ -z ${BRANCH} ]; then
  BRANCH=null
fi
TAG_LATEST=""

TAG_BRANCH="metwork/mfservplugins-rocky9-image:${BRANCH}"
if test "${BRANCH}" = "master"; then
    TAG_LATEST="metwork/mfservplugins-rocky9-image:latest"
fi 

echo "branch=${BRANCH}" >> ${GITHUB_OUTPUT}
echo "os=${OS_VERSION}" >> ${GITHUB_OUTPUT}
echo "tag_branch=${TAG_BRANCH}" >> ${GITHUB_OUTPUT}
echo "tag_latest=${TAG_LATEST}" >> ${GITHUB_OUTPUT}
