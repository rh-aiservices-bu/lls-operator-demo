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

4. **Deploy MCP Servers** (Model Context Protocol servers):
   ```bash
   kubectl apply -k mcp-servers/openshift-mcp/
   ```

5. **Deploy Llama Stack with Configuration** (using ConfigMap):
   ```bash
   kubectl apply -k llama-stack-with-config/
   ```

6. **Deploy Llama Stack Playground** (development/testing instance):
   ```bash
   kubectl apply -k llama-stack-playground/
   ```