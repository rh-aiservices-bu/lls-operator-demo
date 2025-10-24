# Llama Stack Helm Charts

This repository contains Llama Stack deployment configurations for OpenShift/Kubernetes, including Model Context Protocol (MCP) servers and model serving infrastructure using Helm charts.

> **⚠️ Important:** The Llama Stack Operator Instance chart requires **Red Hat OpenShift AI (RHOAI) 2.25 or later**.

## 📦 Helm Charts

All Helm charts are located in the [`charts/`](charts/) directory:

### Model Serving Charts
- **[llama32-3b](charts/llama32-3b/)** - Llama 3.2 3B model serving with vLLM runtime
- **[llama-guard](charts/llama-guard/)** - Llama Guard 3 1B safety model serving

### MCP Server Charts
- **[openshift-mcp](charts/openshift-mcp/)** - OpenShift/Kubernetes MCP server
- **[slack-mcp](charts/slack-mcp/)** - Slack integration MCP server
- **[mcp-weather](charts/mcp-weather/)** - Weather MCP server

### Llama Stack Charts
- **[llama-stack-operator-instance](charts/llama-stack-operator-instance/)** - Llama Stack Operator instances
- **[llama-stack-playground](charts/llama-stack-playground/)** - Llama Stack Playground UI

### Infrastructure Charts
- **[guardrails-orchestrator](charts/guardrails-orchestrator/)** - Guardrails Orchestrator for AI safety
- **[milvus](charts/milvus/)** - Milvus vector database (wrapper chart with dependencies)

## 🚀 Quick Start with Helm

### Prerequisites
- **Red Hat OpenShift AI (RHOAI) 2.25+** (required for Llama Stack Operator)
- Kubernetes 1.19+ or OpenShift 4.x+
- Helm 3.0+
- NVIDIA GPU nodes (for model serving charts)

### Installation

1. **Create the target namespace:**
   ```bash
   kubectl create namespace lls-demo
   helm dependency build ./charts/milvus
   ```

> **Note:** The milvus chart uses Helm dependencies. Run `helm dependency build ./charts/milvus` before installation.

2. **Deploy Model Serving:**

   Deploy Llama 3.2 3B:
   ```bash
   # Standard deployment
   helm install llama32-3b ./charts/llama32-3b --namespace lls-demo

   # BU cluster with Tesla-T4-PRIVATE GPUs
   helm install llama32-3b ./charts/llama32-3b \
     --namespace lls-demo \
     --set inferenceService.buCluster=true
   ```

   Deploy Llama Guard:
   ```bash
   # Standard deployment
   helm install llama-guard ./charts/llama-guard --namespace lls-demo

   # BU cluster with Tesla-T4-PRIVATE GPUs
   helm install llama-guard ./charts/llama-guard \
     --namespace lls-demo \
     --set inferenceService.buCluster=true
   ```

3. **Deploy MCP Servers:**

   Deploy OpenShift MCP:
   ```bash
   helm install openshift-mcp ./charts/openshift-mcp --namespace lls-demo
   ```

   Deploy Slack MCP (requires Slack credentials):
   ```bash
   # First create a secret with your Slack credentials
   kubectl create secret generic slack-credentials \
     --from-literal=slack-bot-token="xoxb-your-token" \
     --from-literal=slack-team-id="T1234567890" \
     --namespace lls-demo

   # Then install the chart
   helm install slack-mcp ./charts/slack-mcp \
     --namespace lls-demo \
     --set slack.existingSecret=slack-credentials
   ```

   Deploy Weather MCP:
   ```bash
   helm install mcp-weather ./charts/mcp-weather --namespace lls-demo
   ```

4. **Deploy Infrastructure Components:**

   Deploy Milvus vector database:
   ```bash
   # First build dependencies
   helm dependency build ./charts/milvus

   # Then install
   helm install milvus ./charts/milvus --namespace lls-demo
   ```

   Deploy Guardrails Orchestrator:
   ```bash
   helm install guardrails-orchestrator ./charts/guardrails-orchestrator --namespace lls-demo
   ```

5. **Deploy Llama Stack Components:**

   > **Note:** Requires RHOAI 2.25+ with Llama Stack Operator installed.

   Deploy Llama Stack Operator Instance (default - local vLLM):
   ```bash
   helm install llama-stack-instance ./charts/llama-stack-operator-instance --namespace lls-demo
   ```

   **Optional: Enable MaaS (Model as a Service):**

   If you want to use external LLM providers via MaaS, first create a secret with your credentials:

   ```bash
   # Set your MaaS configuration
   export INFERENCE_MODEL="llama-3-2-3b"
   export VLLM_URL="XXX"
   export VLLM_TLS_VERIFY="false"
   export VLLM_API_TOKEN="your-maas-api-token-here"

   # Create the secret
   kubectl create secret generic llama-stack-inference-model-secret \
     --from-literal=INFERENCE_MODEL="$INFERENCE_MODEL" \
     --from-literal=VLLM_URL="$VLLM_URL" \
     --from-literal=VLLM_TLS_VERIFY="$VLLM_TLS_VERIFY" \
     --from-literal=VLLM_API_TOKEN="$VLLM_API_TOKEN" \
     --namespace lls-demo

   # Deploy with MaaS enabled
   helm install llama-stack-instance ./charts/llama-stack-operator-instance \
     --namespace lls-demo \
     --set maas.enabled=true
   ```

   > **Note:** When MaaS is enabled, both the local vLLM provider and the MaaS provider are available, giving you access to multiple models simultaneously.

   Deploy Llama Stack Playground:
   ```bash
   helm install llama-stack-playground ./charts/llama-stack-playground --namespace lls-demo
   ```

## 📋 Chart Configuration

Each chart can be customized using Helm values. See individual chart directories for detailed configuration options:

**Model Serving:**
- [llama32-3b values](charts/llama32-3b/values.yaml)
- [llama-guard values](charts/llama-guard/values.yaml)

**MCP Servers:**
- [openshift-mcp values](charts/openshift-mcp/values.yaml)
- [slack-mcp values](charts/slack-mcp/values.yaml)
- [mcp-weather values](charts/mcp-weather/values.yaml)

**Llama Stack:**
- [llama-stack-operator-instance values](charts/llama-stack-operator-instance/values.yaml)
- [llama-stack-playground values](charts/llama-stack-playground/values.yaml)

**Infrastructure:**
- [guardrails-orchestrator values](charts/guardrails-orchestrator/values.yaml)
- [milvus values](charts/milvus/values.yaml)

## 🗑️ Uninstall

```bash
# Uninstall individual components

# Model Serving
helm uninstall llama32-3b --namespace lls-demo
helm uninstall llama-guard --namespace lls-demo

# MCP Servers
helm uninstall openshift-mcp --namespace lls-demo
helm uninstall slack-mcp --namespace lls-demo
helm uninstall mcp-weather --namespace lls-demo

# Infrastructure
helm uninstall milvus --namespace lls-demo
helm uninstall guardrails-orchestrator --namespace lls-demo

# Llama Stack
helm uninstall llama-stack-instance --namespace lls-demo
helm uninstall llama-stack-playground --namespace lls-demo

# Or delete the entire namespace
kubectl delete namespace lls-demo
```