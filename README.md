# lls-summit-connect
LLS Summit Connect

## Deployment

Deploy the components in the following order:

1. **Deploy Llama Stack Operator:**
   ```bash
   kubectl apply -k llama-stack-operator/
   ```

2. **Deploy Model Serving:**
   ```bash
   kubectl apply -k model-serving/
   ```

3. **Deploy MCP Servers:**
   ```bash
   kubectl apply -k mcp-servers/openshift-mcp/
   kubectl apply -k mcp-servers/slack-mcp/
   ```

4. **Deploy Llama Stack (choose one):**
   - **With custom configuration (using ConfigMap):**
     ```bash
     kubectl apply -k llama-stack-with-config/
     ```
   - **Without custom configuration:**
     ```bash
     kubectl apply -k llama-stack-without-config/
     ```

5. **Deploy Llama Stack Playground:**
   ```bash
   kubectl apply -k llama-stack-playground/
   ```
