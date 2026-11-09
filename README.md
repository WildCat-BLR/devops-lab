# DevOps Lab

Ephemeral Azure AKS lab with GitOps and HTTPS.

```mermaid
flowchart LR
    Git[GitHub] --> CI[GitHub Actions]
    CI --> ACR[Azure Container Registry]
    CI --> TF[Terraform]
    TF --> AKS
    Git --> Flux
    subgraph AKS
        Flux[Flux + Helm] --> App[Nginx app]
        Flux --> Traefik
        Flux --> CM[cert-manager]
        Flux --> Grafana
        Flux --> Prometheus
        CM -->|Let's Encrypt TLS| Traefik
        Traefik -->|/| App
        Traefik -->|/grafana/| Grafana
        Grafana -->|queries| Prometheus
    end
    ACR -->|image| App
    Internet -->|Public IP, HTTPS| Traefik
```

```text
app/        Nginx application
charts/     Application Helm chart
clusters/   Flux manifests and monitoring
terraform/  Azure infrastructure and Flux bootstrap
.github/    CI and Terraform workflows
```

Prometheus is internal. Monitoring uses temporary `emptyDir` storage.

[Detailed lab guide](DEVOPS_EPHEMERAL_LAB.md)
