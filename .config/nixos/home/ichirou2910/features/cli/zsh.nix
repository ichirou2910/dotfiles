{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [ zsh-fzf-tab ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      eval "$(fzf --zsh)"
    '';

    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Tweak settings for history
    history = {
      save = 10000;
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    # Set some aliases
    shellAliases = {
      g = "git";
      ka = "killall";
      se = "sudo -e";

      mkdir = "mkdir -vp";
      rm = "rm -rifv";
      mv = "mv -iv";
      cp = "cp -riv";
      cat = "bat --paging=never --style=plain";
      ls = "exa -a --icons";
      tree = "exa --tree --icons";
      nd = "nix develop -c $SHELL";
      rebuild = "sudo nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
      q = "exit";
    };

    plugins = [
      {
          name = "powerlevel10k-config";
          src = ../_resources;
          file = "p10k.zsh";
      }
      {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}


