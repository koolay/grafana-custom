# Grafana Custom Image

预置 VictoriaMetrics 数据源插件的 Grafana 镜像，开箱即用，无需运行时安装。

## 特性

- **开箱即用** - 预装 VictoriaMetrics Logs 和 Metrics 数据源插件
- **生产就绪** - 基于官方 Grafana 12.4.1 镜像
- **自动构建** - 推送代码到 main 分支或手动触发自动构建
- **私有仓库** - 镜像托管在 GitHub Container Registry

## 包含的插件

| 插件 | 描述 |
|------|------|
| `victoriametrics-logs-datasource` | VictoriaMetrics Logs 数据源 |
| `victoriametrics-metrics-datasource` | VictoriaMetrics Metrics 数据源 |

## 快速开始

### 1. 拉取镜像

```bash
docker pull ghcr.io/<your-org>/grafana-plugins:main
```

### 2. 运行容器

```bash
docker run -d -p 3000:3000 \
  --name grafana \
  -e GF_SECURITY_ADMIN_USER=admin \
  -e GF_SECURITY_ADMIN_PASSWORD=<your-password> \
  -v grafana-data:/var/lib/grafana \
  ghcr.io/<your-org>/grafana-plugins:main
```

### 3. 访问 Grafana

打开浏览器访问 `http://localhost:3000`，使用配置的账号登录。

## 构建方式

### 本地构建

```bash
docker build -t grafana-custom .
```

### GitHub Actions

- **自动触发**: 推送代码到 `main` 分支
- **手动触发**: GitHub Actions 页面点击 "Run workflow"

镜像自动推送到：`ghcr.io/<your-org>/grafana-plugins:main`

## 配置

### 环境变量

| 变量 | 描述 | 默认值 |
|------|------|--------|
| `GF_SECURITY_ADMIN_USER` | 管理员账号 | `admin` |
| `GF_SECURITY_ADMIN_PASSWORD` | 管理员密码 | `admin` |
| `GF_INSTALL_PLUGINS` | 额外插件（已预装，无需配置） | - |

### 持久化数据

```bash
# 使用 Docker volume
docker volume create grafana-data
docker run -v grafana-data:/var/lib/grafana ...

# 或绑定挂载到主机
docker run -v /path/on/host:/var/lib/grafana ...
```

## GitHub 仓库配置

### 1. 创建仓库

在 GitHub 创建新仓库：

```bash
git remote add origin https://github.com/<your-org>/grafana-plugins.git
git push -u origin main
```

### 2. 配置 Actions 权限

1. 进入 **Settings → Actions → General**
2. **Workflow permissions** 设置为 **Read and write permissions**
3. 勾选 **Allow GitHub Actions to create and approve pull requests**

### 3. 验证构建

推送后，在 **Actions** 标签页查看构建状态。构建成功后，在 **Packages** 页面查看镜像。

## 插件版本管理

如需锁定插件版本，修改 `Dockerfile`：

```dockerfile
RUN grafana-cli plugins install victoriametrics-logs-datasource:<version> && \
    grafana-cli plugins install victoriametrics-metrics-datasource:<version>
```

## 故障排查

### 构建失败

- 检查基础镜像是否存在：`docker pull ghcr.io/koolay/grafana/grafana:12.4.1`
- 检查插件名称是否正确：`grafana-cli plugins ls-remote | grep victoriametrics`

### 镜像推送失败

- 确认 Actions 权限已配置
- 确认 GITHUB_TOKEN 权限正确（workflow 中已配置）

## License

继承基础镜像许可证。
