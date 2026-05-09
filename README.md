# llm-on-aks-azure

> Deploy, serve, and observe an open-source LLM (Phi-3-mini) on Azure Kubernetes Service — fully automated with Terraform, monitored via ELK Stack + Azure Monitor, and shipped through an Azure DevOps CI/CD pipeline.

![Architecture](docs/architecture.png)
![Azure](https://img.shields.io/badge/Cloud-Microsoft%20Azure-0078D4?logo=microsoftazure)
![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Runtime-AKS-326CE5?logo=kubernetes)
![Model](https://img.shields.io/badge/LLM-Phi--3--mini-412991?logo=microsoft)
![License](https://img.shields.io/badge/License-MIT-green)

---

## What this project does

This repository demonstrates a **production-grade, end-to-end deployment of Microsoft's Phi-3-mini language model on Azure Kubernetes Service (AKS)** — built to showcase how a senior cloud engineer can design, automate, and operate AI inference infrastructure on Azure.

Everything in this repo is Infrastructure as Code. Nothing is clicked in the portal.

### Why Phi-3-mini?

Phi-3-mini is Microsoft's open-source small language model (~3.8B parameters). It was chosen deliberately for this project because:

- Runs efficiently on **CPU-only AKS nodes** — no expensive GPU instances required
- Native Azure provenance — aligns with an Azure-first architecture
- Ideal for demonstrating **cost-efficient AI inference at scale** using AKS autoscaling
- Openly available on Hugging Face with an MIT licence

---

## Architecture overview

```
                        ┌─────────────────────────────────────────┐
                        │           Azure Subscription             │
                        │                                          │
  User / API Client ───▶│  Azure API Management (rate limiting)   │
                        │           │                              │
                        │    ┌──────▼──────┐                      │
                        │    │  AKS Cluster │                      │
                        │    │             │                       │
                        │    │ ┌─────────┐ │   ┌───────────────┐  │
                        │    │ │Phi-3 Pod│ │   │ Azure Monitor  │  │
                        │    │ │(llama.  │ │──▶│ + Log Analytics│  │
                        │    │ │ cpp /   │ │   └───────────────┘  │
                        │    │ │ ollama) │ │                       │
                        │    │ └─────────┘ │   ┌───────────────┐  │
                        │    │  HPA + CA   │   │  ELK Stack    │  │
                        │    └─────────────┘   │  (Kibana dash)│  │
                        │           │           └───────────────┘  │
                        │    ┌──────▼──────────────────────┐      │
                        │    │  Terraform-managed resources  │      │
                        │    │  AKS · ACR · Key Vault ·     │      │
                        │    │  Storage · VNet · Monitor     │      │
                        │    └──────────────────────────────┘      │
                        └─────────────────────────────────────────┘
                                        │
                              Azure DevOps Pipeline
                              (build → test → deploy)
```

---

## Tech stack

| Layer | Technology |
|---|---|
| Cloud platform | Microsoft Azure |
| Container orchestration | Azure Kubernetes Service (AKS) |
| Infrastructure as Code | Terraform (HashiCorp) |
| LLM runtime | Ollama / llama.cpp serving Phi-3-mini |
| Container registry | Azure Container Registry (ACR) |
| Secrets management | Azure Key Vault |
| CI/CD | Azure DevOps Pipelines |
| Observability — metrics | Azure Monitor + Log Analytics |
| Observability — logs | ELK Stack (Elasticsearch, Logstash, Kibana) |
| Autoscaling | Horizontal Pod Autoscaler (HPA) + Cluster Autoscaler |
| Networking | Azure Virtual Network, Private Endpoints |

---

## Repository structure

```
llm-on-aks-azure/
│
├── terraform/                  # All Azure infrastructure as code
│   ├── main.tf                 # Root module — AKS, ACR, VNet
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── aks/                # AKS cluster + node pools
│   │   ├── networking/         # VNet, subnets, private endpoints
│   │   ├── keyvault/           # Key Vault + access policies
│   │   ├── monitoring/         # Azure Monitor, Log Analytics workspace
│   │   └── acr/                # Azure Container Registry
│   └── environments/
│       ├── dev.tfvars
│       └── prod.tfvars
│
├── kubernetes/                 # K8s manifests
│   ├── deployment.yaml         # Phi-3-mini pod spec
│   ├── service.yaml            # ClusterIP + LoadBalancer
│   ├── hpa.yaml                # Horizontal Pod Autoscaler
│   ├── configmap.yaml          # Model config
│   └── namespace.yaml
│
├── observability/              # ELK + Azure Monitor config
│   ├── elasticsearch/
│   ├── logstash/
│   │   └── pipeline.conf       # Ingest AKS logs → Elasticsearch
│   └── kibana/
│       └── dashboards/         # Exported Kibana dashboard JSON
│
├── pipelines/                  # Azure DevOps pipeline definitions
│   ├── azure-pipelines.yml     # Main CI/CD pipeline
│   └── templates/
│       ├── build.yml
│       ├── test.yml
│       └── deploy.yml
│
├── docs/
│   └── architecture.png
│
├── scripts/
│   ├── bootstrap.sh            # One-command environment setup
│   └── validate.sh             # Pre-deploy checks
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## Prerequisites

Before deploying, ensure you have:

- An **Azure subscription** with Contributor access
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) `>= 2.50`
- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.6`
- [kubectl](https://kubernetes.io/docs/tasks/tools/) `>= 1.28`
- [Helm](https://helm.sh/docs/intro/install/) `>= 3.12`
- An **Azure DevOps organisation** (free tier works)

---

## Quick start

### 1. Clone and configure

```bash
git clone https://github.com/VarunSinghRai/llm-on-aks-azure.git
cd llm-on-aks-azure
cp terraform/environments/dev.tfvars.example terraform/environments/dev.tfvars
# Edit dev.tfvars with your subscription ID, region, resource group name
```

### 2. Provision infrastructure with Terraform

```bash
cd terraform
terraform init
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
```

This provisions: AKS cluster, ACR, VNet with private endpoints, Key Vault, Log Analytics workspace, and Azure Monitor alerts.

### 3. Connect to AKS and deploy the model

```bash
az aks get-credentials --resource-group <rg-name> --name <aks-name>
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/
```

### 4. Verify the model is running

```bash
kubectl get pods -n llm
kubectl port-forward svc/phi3-service 11434:11434 -n llm

# Test inference
curl http://localhost:11434/api/generate \
  -d '{"model": "phi3", "prompt": "What is Azure Kubernetes Service?"}'
```

### 5. Access Kibana dashboard

```bash
kubectl port-forward svc/kibana 5601:5601 -n observability
# Open http://localhost:5601
# Import the dashboard from observability/kibana/dashboards/
```

---

## Key engineering decisions

**Why CPU nodes instead of GPU?**
GPU node pools (NC-series) cost 10–20x more than CPU nodes. Phi-3-mini runs adequately on `Standard_D4s_v3` nodes for low-to-medium throughput workloads. This project intentionally demonstrates cost-efficient AI hosting — a critical real-world concern for platform engineers managing cloud spend.

**Why Ollama as the serving runtime?**
Ollama provides a simple REST API, built-in model management, and efficient CPU inference. It eliminates the need to build a custom inference server, letting the project focus on infrastructure concerns (IaC, observability, autoscaling) rather than ML serving code.

**Why ELK alongside Azure Monitor?**
Azure Monitor covers infrastructure-level metrics (node CPU, pod restarts, HPA events). ELK handles application-level log ingestion from the inference pods — parsing prompt latency, token throughput, and error rates. Both together give full-stack observability, mirroring production patterns used at enterprise scale.

---

## Observability

The project ships two Kibana dashboards:

- **Inference dashboard** — tracks request rate, average token latency (ms), error rate, and prompt length distribution
- **Infrastructure dashboard** — AKS node utilisation, pod scaling events, HPA trigger history

Azure Monitor alerts are configured for:
- Pod crash loop backoff
- Node CPU > 80% for 5 minutes
- Inference latency p95 > 5 seconds

---

## Cost estimate (Azure, East US region)

| Resource | SKU | Estimated monthly cost |
|---|---|---|
| AKS node pool (1–3 nodes) | Standard_D4s_v3 | ₹12,000 – ₹36,000 |
| Azure Container Registry | Basic | ₹400 |
| Log Analytics workspace | Pay-per-GB (~5 GB/day) | ₹3,000 |
| Azure Key Vault | Standard | ₹350 |
| VNet + Private Endpoints | — | ₹800 |
| **Total (1 node baseline)** | | **~₹16,500 / month** |

> Cluster Autoscaler scales nodes to zero during idle periods, significantly reducing costs in non-production environments.

---

## What I learned building this

This project was built to bridge my background in Azure infrastructure administration with the emerging discipline of AI workload operations. Key engineering challenges encountered:

- Sizing AKS node pools for LLM inference without GPU — benchmarking Phi-3-mini throughput on D-series VMs
- Configuring Logstash pipelines to parse structured inference logs from Ollama's output format
- Tuning HPA triggers for inference workloads (token latency is a better scaling metric than CPU for LLM pods)
- Managing model weights securely — pulling from Hugging Face at pod startup vs. baking into a container image

---

## Roadmap

- [ ] Add Azure API Management gateway with rate limiting and auth
- [ ] Integrate Azure OpenAI as a fallback when Phi-3 load is high
- [ ] Add GitOps deployment via ArgoCD
- [ ] Multi-model serving: Phi-3-mini + Mistral side by side
- [ ] FinOps dashboard — real-time cost per inference request

---

## About the author

**Varun Singh Rai** — Senior Cloud & Platform Engineer with 15+ years managing Azure infrastructure at scale. Experienced in AKS, Terraform IaC, Azure DevOps CI/CD, and ELK-stack observability. Currently completing AZ-700, AZ-500, AZ-305, and CKA certifications.

[LinkedIn](https://www.linkedin.com/in/varun-singh-rai-b4b47a1a/) · [GitHub](https://github.com/VarunSinghRai)

---

## Licence

MIT — see [LICENSE](LICENSE) for details.
