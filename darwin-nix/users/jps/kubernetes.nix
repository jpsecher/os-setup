{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl  # Kubenetes controller
    minikube  # Kubernetes cluser @ home
  ];
}
