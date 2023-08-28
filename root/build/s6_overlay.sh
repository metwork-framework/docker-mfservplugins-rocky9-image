#!/bin/bash

set -e

VERSION=2.2.0.3
ARCHIVE_NAME=s6-overlay-amd64.tar.gz
ARCHIVE_URL="https://github.com/just-containers/s6-overlay/releases/download/v${VERSION}/${ARCHIVE_NAME}"
BUILD_DIR=/build

wget -O "${BUILD_DIR}/${ARCHIVE_NAME}" "${ARCHIVE_URL}"
tar xzf "${BUILD_DIR}/${ARCHIVE_NAME}" -C / --exclude="./bin"
tar xzf "${BUILD_DIR}/${ARCHIVE_NAME}" -C /usr ./bin
rm -f "${BUILD_DIR}/${ARCHIVE_NAME}"
