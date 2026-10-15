#!/usr/bin/env bash
# Copyright 2023 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# Use this script to sync the task and pipeline definitions with those
# found in the conforma/cli repository.
# Usage:
#   sync-ec-cli-tasks.sh <PATH_TO_EC_CLI_REPO>

set -o errexit
set -o pipefail
set -o nounset

EC_CLI_REPO_PATH="${1}"

# pin unpinned quay.io/conforma/cli image references in the given directory
pin_images() {
  local dir=${1}
  if [[ ! -d "${dir}" ]]; then
    return
  fi
  pushd "${dir}" > /dev/null
  images="$(grep -r -h -o -w 'quay.io/conforma/cli:.*' | grep -v '@' | sort -u || true)"
  if [[ -z "${images}" ]]; then
    echo "No unpinned images found in ${dir} - all images are already pinned"
    popd > /dev/null
    return
  fi
  for image in $images; do
    echo "Resolving image $image"
    digest="$(skopeo manifest-digest <(skopeo inspect --raw "docker://${image}"))"
    pinned_image="${image}@${digest}"
    echo "↳ ${pinned_image}"
    find . -type f -exec sed -i "s!${image}!${pinned_image}!g" {} +
  done
  popd > /dev/null
}

rsync -r --delete "${EC_CLI_REPO_PATH}/tasks/" tasks/
# older release branches don't have pipelines/
if [[ -d "${EC_CLI_REPO_PATH}/pipelines" ]]; then
  rsync -r --delete "${EC_CLI_REPO_PATH}/pipelines/" pipelines/
fi
pin_images tasks
pin_images pipelines
