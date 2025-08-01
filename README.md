# LLS Summit Connect

This repository contains Llama Stack deployment configurations for OpenShift/Kubernetes, including Model Context Protocol (MCP) servers and model serving infrastructure.

## Deployment

Deploy the components in the following order:

1. **Create the target namespace:**
   ```bash
   kubectl create namespace lls-demo
   ```

2. **Deploy Llama Stack Operator** (deploys to its own namespace):
   ```bash
   kubectl apply -k llama-stack-operator/
   ```

3. **Deploy Model Serving** (KServe InferenceService with vLLM runtime):
   ```bash
   kubectl apply -k model-serving/
   ```

4. **Deploy Llama Guard** (Llama Guard safety model serving):
   ```bash
   kubectl apply -k llama-guard/
   ```

5. **Deploy MCP Servers** (Model Context Protocol servers):
   ```bash
   kubectl apply -k mcp-servers/openshift-mcp/
   ```

6. **Deploy Llama Stack with Configuration** (using ConfigMap):
   ```bash
   kubectl apply -k llama-stack-with-config/
   ```

7. **Deploy Llama Stack Playground** (development/testing instance):
   ```bash
   kubectl apply -k llama-stack-playground/
   ```

## Prompts

```
give me the kubernetes services in the lls-demo namespace
```