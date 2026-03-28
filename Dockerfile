FROM ghcr.io/koolay/grafana/grafana:12.4.1

USER root

# 预装 VictoriaMetrics 数据源插件（下载解压方式，构建速度快）
RUN PLUGINS_DIR="/var/lib/grafana/plugins" && \
    # 获取 Logs 插件最新版本
    LOGS_VER=$(curl -sS https://api.github.com/repos/VictoriaMetrics/victorialogs-datasource/releases/latest | grep -oE '"tag_name": "v[0-9]+\.[0-9]+\.[0-9]+"' | cut -d'"' -f4) && \
    # 创建临时目录
    mkdir -p /tmp/victorialogs && \
    # 下载 Logs 插件
    curl -fsSL -o /tmp/logs.tar.gz "https://github.com/VictoriaMetrics/victorialogs-datasource/releases/download/${LOGS_VER}/victoriametrics-logs-datasource-${LOGS_VER}.tar.gz" && \
    # 解压到临时目录
    tar -xzf /tmp/logs.tar.gz -C /tmp/victorialogs && \
    # 移动插件到目标目录（处理可能的版本目录名）
    mv /tmp/victorialogs/*/ "${PLUGINS_DIR}/victoriametrics-logs-datasource/" && \
    # 设置正确的权限
    chown -R grafana:grafana "${PLUGINS_DIR}/victoriametrics-logs-datasource/" && \
    # 清理临时文件和缓存
    rm -rf /tmp/logs.tar.gz /tmp/victorialogs

USER grafana
