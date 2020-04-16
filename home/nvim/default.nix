{ pkgs, ... }:
{
  home.file.".config/nvim/coc-settings.json".source = ./coc-settings.json;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      airline
      gruvbox
      vim-nix
      coc-nvim
      coc-python
    ];
  };
}
