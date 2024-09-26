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
    # lsp
    roslyn-ls
    phpactor
    lua-language-server
    nodePackages_latest.typescript-language-server

    # debugger
    netcoredbg

    # formater/linter
    csharpier
    stylua
    shfmt
    eslint_d
    prettierd
  ];
}
