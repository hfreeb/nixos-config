{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome3.adwaita-icon-theme # Required for GTK wave icons
    gtkwave
    verilog
  ];
}
