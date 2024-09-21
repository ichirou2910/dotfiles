{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./nnn.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    distrobox

    tmux

    eza
    ripgrep
    htop
    jq
    fd
    alejandra

    unzip
    atool
    yadm
  ];
}
