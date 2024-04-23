{config, inputs, pkgs, ...}:
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./neovim
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";

  home.packages = with pkgs; [
    rustup

    # dev tools
    ripgrep
    jq
    yq-go
    eza
    fzf

    # networking tools
    dnsutils
    nmap
    ipcalc
   
    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
  ];

  programs.git = {
      enable = true;
      userName = "Nicholas Clare";
      userEmail = "nick@conjugate.dev";
  };
      
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "eza";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
