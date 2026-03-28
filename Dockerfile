FROM ghcr.io/koolay/grafana/grafana:12.4.1

USER root

RUN grafana-cli plugins install victoriametrics-logs-datasource && \
    grafana-cli plugins install victoriametrics-metrics-datasource && \
    rm -rf /var/lib/grafana/plugins/.cache

USER grafana
