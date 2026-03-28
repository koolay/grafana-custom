# Grafana Custom Image

基于官方 Grafana 镜像，预置 VictoriaMetrics 数据源插件。

## 包含的插件

- `victoriametrics-logs-datasource` - VictoriaMetrics Logs 数据源
- `victoriametrics-metrics-datasource` - VictoriaMetrics Metrics 数据源

## 使用方式

### 拉取镜像

```bash
docker pull ghcr.io/<your-org>/grafana-plugins:main
```

### 运行容器

```bash
docker run -d -p 3000:3000 \
  -e GF_SECURITY_ADMIN_USER=admin \
  -e GF_SECURITY_ADMIN_PASSWORD=your-password \
  ghcr.io/<your-org>/grafana-plugins:main
```

## 构建

### 本地构建

```bash
docker build -t grafana-custom .
```

### GitHub Actions

推送代码到 main 分支或手动触发 workflow：

```bash
git push origin main
```

或在 GitHub Actions 页面点击 "Run workflow"。

## 配置 GitHub Secrets

在 GitHub 仓库设置中，确保启用 Actions 并配置以下权限：

1. 进入 **Settings > Actions > General**
2. 确保 **Workflow permissions** 设置为 **Read and write permissions**
3. 勾选 **Allow GitHub Actions to create and approve pull requests**

镜像会自动推送到 GitHub Container Registry (ghcr.io)。
