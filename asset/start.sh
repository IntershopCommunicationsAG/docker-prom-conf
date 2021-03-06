#!/usr/bin/env sh
#
# Copyright 2015 Intershop Communications AG.
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
#  limitations under the License.
#
set -eo pipefail

# Loop until confd has updated the config
until confd -onetime -backend rancher; do
  echo "[confd] waiting for confd to refresh"
  sleep 5
done

# Start confd daemon
confd --backend rancher
