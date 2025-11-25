{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helm-ls  # Helm language server
    k9s  # Kubernetes
    kubectl  # Kubenetes controller
    kubernetes-helm  # Packages
    minikube  # Kubernetes cluser @ home
  ];
}
