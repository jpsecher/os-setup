{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps;
      [
        python-lsp-server
        python-lsp-ruff
        pylsp-rope
      ] ++ python-lsp-server.optional-dependencies.all))
  ];
}

