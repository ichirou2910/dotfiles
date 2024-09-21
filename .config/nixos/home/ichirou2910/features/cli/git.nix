{
  pkgs,
  config,
  lib,
  ...
}: let
  ssh = "${pkgs.openssh}/bin/ssh";

in {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      a = "!git status --short | fzf -m | awk '{print $2}' | xargs git add";
      d = "diff";
      f = "fetch";
      m = "merge";
      co = "checkout";
      ci = "commit";
      ca = "commit -a";
      cm = "commit -m";
      ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
      st = "status";
      br = "branch";
      ba = "branch -a";
      bm = "branch --merged";
      bn = "branch --no-merged";
      r = "restore";
      rr = "restore --staged";
      df = "!git hist | fzf | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      hist = "log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
      llog = "log --graph --name-status --pretty=format:\"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset\" --date=relative";
      open = "!hub browse";
      type = "cat-file -t";
      dump = "cat-file -p";
      find = "!f() { git log --pretty=format:\"%h %cd [%cn] %s%d\" --date=relative -S'pretty' -S\"$@\" | peco | awk '{print $1}' | xargs -I {} git diff {}^ {}; }; f";
      # edit conflicted file on merge;
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
      # add conflicted file on merge;
      add-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; git add `f`";
    };
    userName = "ichirou2910";
    userEmail = lib.mkDefault "ichiroukeita2910@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
