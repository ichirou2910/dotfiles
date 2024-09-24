{ pkgs, lib, config, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    roslyn-ls
    phpactor
    lua-language-server
    nodePackages_latest.typescript-language-server

    netcoredbg

    csharpier
    stylua
    shfmt
    eslint_d
  ];
}
