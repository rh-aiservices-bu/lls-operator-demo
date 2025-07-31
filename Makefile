# LLS Summit Connect Makefile
# Deploy Llama Stack components to Kubernetes/OpenShift

NAMESPACE = lls-demo

.PHONY: all create-namespace deploy-operator deploy-model-serving deploy-mcp-servers deploy-llama-stack deploy-playground clean help

# Default target - deploy everything
all: create-namespace deploy-operator deploy-model-serving deploy-mcp-servers deploy-llama-stack deploy-playground
	@echo "✅ All components deployed successfully!"

# Create the target namespace
create-namespace:
	@echo "📦 Creating namespace $(NAMESPACE)..."
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -

# Deploy Llama Stack Operator (deploys to its own namespace)
deploy-operator:
	@echo "🚀 Deploying Llama Stack Operator..."
	kubectl apply -k llama-stack-operator/

# Deploy Model Serving (KServe InferenceService with vLLM runtime)
deploy-model-serving:
	@echo "🤖 Deploying Model Serving..."
	kubectl apply -k model-serving/

# Deploy MCP Servers (Model Context Protocol servers)
deploy-mcp-servers:
	@echo "🔌 Deploying MCP Servers..."
	kubectl apply -k mcp-servers/openshift-mcp/
	kubectl apply -k mcp-servers/slack-mcp/

# Deploy Llama Stack with Configuration (using ConfigMap)
deploy-llama-stack:
	@echo "🦙 Deploying Llama Stack with Configuration..."
	kubectl apply -k llama-stack-with-config/

# Deploy Llama Stack Playground (development/testing instance)
deploy-playground:
	@echo "🎮 Deploying Llama Stack Playground..."
	kubectl apply -k llama-stack-playground/

# Clean up all resources
clean:
	@echo "🧹 Cleaning up resources..."
	kubectl delete -k llama-stack-playground/ --ignore-not-found=true
	kubectl delete -k llama-stack-with-config/ --ignore-not-found=true
	kubectl delete -k mcp-servers/slack-mcp/ --ignore-not-found=true
	kubectl delete -k mcp-servers/openshift-mcp/ --ignore-not-found=true
	kubectl delete -k model-serving/ --ignore-not-found=true
	kubectl delete -k llama-stack-operator/ --ignore-not-found=true
	kubectl delete namespace $(NAMESPACE) --ignore-not-found=true
	@echo "✅ Cleanup completed!"

# Show help
help:
	@echo "LLS Summit Connect Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make all              Deploy all components"
	@echo "  make create-namespace Create the lls-demo namespace"
	@echo "  make deploy-operator  Deploy Llama Stack Operator"
	@echo "  make deploy-model-serving Deploy Model Serving"
	@echo "  make deploy-mcp-servers Deploy MCP Servers"
	@echo "  make deploy-llama-stack Deploy Llama Stack with Configuration"
	@echo "  make deploy-playground Deploy Llama Stack Playground"
	@echo "  make clean            Remove all deployed resources"
	@echo "  make help             Show this help message"