{ pkgs, ... }:
{
  console.useXkbConfig = true;

  fonts.fonts = with pkgs; [ font-awesome iosevka-term ];

  services.xserver = {
    enable = true;

    layout = "gb";
    xkbOptions = "caps:escape";

    libinput = {
      enable = true;
      middleEmulation = false;
      accelProfile = "flat";
      accelSpeed = "0";
    };

    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";

    windowManager.i3.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
