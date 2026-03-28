FROM ghcr.io/koolay/grafana/grafana:12.4.1

USER root

# 预装 VictoriaMetrics Logs 数据源插件
RUN PLUGINS_DIR="/var/lib/grafana/plugins" && \
    PLUGIN_DIR="${PLUGINS_DIR}/victoriametrics-logs-datasource" && \
    # 获取最新版本号 (如 v0.26.3)
    LOGS_VER=$(curl -sS https://api.github.com/repos/VictoriaMetrics/victorialogs-datasource/releases/latest | grep -oE '"tag_name": "v[0-9]+\.[0-9]+\.[0-9]+"' | cut -d'"' -f4) && \
    echo "Installing victoriametrics-logs-datasource version: ${LOGS_VER}" && \
    # 下载并解压插件
    curl -fsSL "https://github.com/VictoriaMetrics/victorialogs-datasource/releases/download/${LOGS_VER}/victoriametrics-logs-datasource-${LOGS_VER}.tar.gz" | \
        tar -xzf - -C "${PLUGINS_DIR}" && \
    # 设置正确的权限 (472 是 grafana 用户的 UID/GID)
    chown -R 472:472 "${PLUGIN_DIR}" && \
    echo "Plugin installed successfully"

USER grafana
