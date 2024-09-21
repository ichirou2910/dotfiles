{ pkgs, lib, config, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            vscodevim.vim
        ];
    };
}
