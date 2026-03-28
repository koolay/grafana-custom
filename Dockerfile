FROM ghcr.io/koolay/grafana/grafana:12.4.1

USER root

RUN grafana-cli plugins install victoriametrics-metrics-datasource && \
    grafana-cli plugins install bytesparanoia-victorialogs-datasource && \
    rm -rf /var/lib/grafana/plugins/.cache

USER grafana
