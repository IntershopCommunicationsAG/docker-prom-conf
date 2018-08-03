# Prometheus Config

This image provides Prometheus configuration via Rancher Metadata. The provided Rancher Metadata is written to `/etc/prom-conf/prometheus.yml` of the container and can be used by a Prometheus Container via `volumes_from`.

Configuration allows to specify:
* prometheus config file content servers via `metadata/prometheus/config`
See example configuration below.

# Example Rancher configuration

`docker-compose.yml`:

```
version: '2'
services:
  prom-conf:
    tty: true
    image: intershopde/docker-prom-conf

  prometheus:
    tty: true
    image: prom/prometheus:v2.1.0
    command: --config.file=/etc/prom-conf/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/etc/prometheus/console_libraries --web.console.templates=/etc/prometheus/consoles
    ports:
      - 9090:9090
    labels:
      io.rancher.sidekicks: prom-conf
      io.rancher.scheduler.affinity:host_label: prometheus
    volumes_from:
      - prom-conf
    volumes:
      - prometheus-data:/prometheus
    volume_driver: local
```

`rancher-compose.yml`:

```
version: '2'
services:
  prometheus:
  scale: 1
  health_check:
    port: 9090
    interval: 5000
    unhealthy_threshold: 3
    request_line: ''
    healthy_threshold: 2
    response_timeout: 5000
  metadata:
    prometheus:
      config: |
        global:
          scrape_interval:     15s
          evaluation_interval: 15s
          external_labels:
            monitor: 'exporter-metrics'

        alerting:
          alertmanagers:
            - static_configs:
              - targets: ["alertmanager:9093"]

        scrape_configs:

        - job_name: 'Prometheus'
          static_configs:
            - targets:
              - '127.0.0.1:9090'
```

# License

Copyright 2014-2017 Intershop Communications.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Third-party License confd

Github: https://github.com/kelseyhightower/confd

Licensed under the MIT license.

```
Copyright (c) 2013 Kelsey Hightower

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
