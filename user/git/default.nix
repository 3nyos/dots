{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      safe.directory = "/home/user/.nixos";
      user = {
        email = "lovelypizzaparty@gmail.com";
        name = "3nyos";
      };
    };
  };
}
