{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./nnn.nix
    ./shell.nix
    ./ssh.nix
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

    util-linux
    pciutils
    usbutils

    # utilities
    unzip
    atool
    yadm

    # networking
    inetutils
    dig
  ];
}
