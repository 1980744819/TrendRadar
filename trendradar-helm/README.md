# TrendRadar Helm Chart

This Helm chart deploys TrendRadar, a hot news aggregator and notification service, to a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installation

### Add the Helm Repository

```bash
# Add the repository
helm repo add trendradar https://example.com/helm-charts
helm repo update
```

### Install the Chart

```bash
# Install with default values
helm install trendradar trendradar/trendradar

# Install with custom values
helm install trendradar trendradar/trendradar -f values-custom.yaml
```

## Configuration

The following table lists the configurable parameters of the TrendRadar chart and their default values.

### Basic Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | Image repository | `wantcat/trendradar` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `Always` |
| `mcp.enabled` | Enable MCP service for AI analysis | `false` |
| `mcp.image.repository` | MCP image repository | `wantcat/trendradar-mcp` |
| `mcp.image.tag` | MCP image tag | `latest` |
| `mcp.image.pullPolicy` | MCP image pull policy | `Always` |

### Persistence

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent storage | `true` |
| `persistence.size` | Storage size | `1Gi` |
| `persistence.accessMode` | Access mode | `ReadWriteOnce` |
| `persistence.storageClass` | Storage class name | `""` |

### Configuration Files

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.configYaml` | Content of config.yaml | See values.yaml |
| `config.frequencyWords` | Content of frequency_words.txt | See values.yaml |
| `config.aiAnalysisPrompt` | Content of ai_analysis_prompt.txt | See values.yaml |

### Environment Variables

| Parameter | Description | Default |
|-----------|-------------|---------|
| `env.ENABLE_WEBSERVER` | Enable web server | `false` |
| `env.WEBSERVER_PORT` | Web server port | `8080` |
| `env.FEISHU_WEBHOOK_URL` | Feishu webhook URL | `""` |
| `env.WEWORK_WEBHOOK_URL` | WeWork webhook URL | `""` |
| `env.DINGTALK_WEBHOOK_URL` | DingTalk webhook URL | `""` |
| `env.TELEGRAM_TOKEN` | Telegram token | `""` |
| `env.TELEGRAM_CHAT_ID` | Telegram chat ID | `""` |
| `env.AI_ANALYSIS_ENABLED` | Enable AI analysis | `false` |
| `env.AI_API_KEY` | AI API key | `""` |
| `env.AI_MODEL` | AI model | `deepseek/deepseek-chat` |

## Custom Configuration

To customize the deployment, create a `values-custom.yaml` file and override the default values.

### Example: Enable AI Analysis

```yaml
mcp:
  enabled: true

env:
  AI_ANALYSIS_ENABLED: "true"
  AI_API_KEY: "your-ai-api-key"
```

### Example: Configure Notification Channels

```yaml
env:
  FEISHU_WEBHOOK_URL: "https://open.feishu.cn/open-apis/bot/v2/hook/your-webhook-url"
  WEWORK_WEBHOOK_URL: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=your-key"
  DINGTALK_WEBHOOK_URL: "https://oapi.dingtalk.com/robot/send?access_token=your-token"
```

## Accessing the Application

### Web Interface

If the web server is enabled, you can access the web interface at:

```
http://<cluster-ip>:8080
```

### MCP Service

If the MCP service is enabled, it can be accessed at:

```
http://<cluster-ip>:3333/mcp
```

## Uninstallation

To uninstall the chart:

```bash
helm uninstall trendradar
```

This will remove all resources created by the chart except for persistent volume claims, which need to be deleted manually:

```bash
kubectl delete pvc trendradar-pvc
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods
kubectl describe pod <pod-name>
```

### Check Logs

```bash
kubectl logs <pod-name>
```

### Check ConfigMap

```bash
kubectl get configmap trendradar-config -o yaml
```

### Check Persistent Volume Claim

```bash
kubectl get pvc
kubectl describe pvc trendradar-pvc
```

## Upgrading

To upgrade the chart:

```bash
helm upgrade trendradar trendradar/trendradar
```

## Support

For issues and feature requests, please visit the [TrendRadar GitHub repository](https://github.com/sansan0/TrendRadar).
