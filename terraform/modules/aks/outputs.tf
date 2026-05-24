output "cluster_name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.llm_on_aks.name
}

output "cluster_id" {
  description = "Resource ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.llm_on_aks.id
}

output "kube_config_raw" {
  description = "Raw kubeconfig content for the cluster."
  value       = azurerm_kubernetes_cluster.llm_on_aks.kube_config_raw
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet managed identity (used for ACR pull role assignment)."
  value       = azurerm_kubernetes_cluster.llm_on_aks.kubelet_identity[0].object_id
}
