{ pkgs, stateVersion, ... }:

{
  home.username = "mikkel";
  home.homeDirectory = "/home/mikkel";

  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    neovim
    zsh
    tmux
    ripgrep
    fd
    fzf
    bat
    exa
    btop
    jq
    fastfetch
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -alh";
      la = "ls -A";
      l = "ls -CF";
      rebuild = "sudo nixos-rebuild switch --flake";
    };
    sessionVariables = {
      EDITOR = "vim";
      DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    };
  };

  programs.git = {
    enable = true;
    userName = "Mikkel";
    userEmail = "mikkel@example.org";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}