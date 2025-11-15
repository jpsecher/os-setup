{ pkgs, ... }:
{
  home.packages = with pkgs; [
    k9s  # Kubernetes
    kubectl  # Kubenetes controller
    minikube  # Kubernetes cluser @ home
  ];
}
