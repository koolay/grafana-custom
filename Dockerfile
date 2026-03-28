FROM ghcr.io/koolay/grafana/grafana:12.4.1

USER root

RUN grafana-cli plugins install victoriametrics-logs-datasource && \
    grafana-cli plugins install victoriametrics-metrics-datasource && \
    rm -rf /var/lib/grafana/plugins/.cache

USER grafana

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/api/health || exit 1
