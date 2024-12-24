{
  config,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "--" = "cd -";
      "clean" = "sudo nix-collect-garbage --delete-older-than 3d";
      "n" = "sudo -E -s nvim";
    };
    interactiveShellInit = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
  };
}
