{pkgs, ...}: {
  imports = [
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    clipboard.register = "unnamedplus";
    colorschemes.tokyonight.enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      neoconf-nvim
    ];
    globals.mapleader = " ";

    plugins = {
      conform-nvim = {
        enable = true;
        formatOnSave = ''
          {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        '';
      };

      crates-nvim.enable = true;
      floaterm.enable = true;
      none-ls.enable = true;
      nvim-autopairs.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };
      treesitter-textobjects.enable = true;
      treesitter-context.enable = true;
    };
  };
}
