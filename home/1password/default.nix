{ lib, fetchurl, appimageTools }:

let
  pname = "1password";
  version = "0.8.3-1";
  name = "${pname}-${version}"; 

  src = fetchurl {
    url = "https://onepassword.s3.amazonaws.com/linux/appimage/1password-${version}.AppImage";
    sha256 = "06kzvdqsd7viaj7qz0ywi4k85662084cx73psk1b2hphklvdl24c";
    name = "${pname}-${version}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in appimageTools.wrapType2 {
  inherit name src;

  multiPkgs = null;
  extraPkgs = pkgs: appimageTools.defaultFhsEnvArgs.multiPkgs pkgs;

  extraInstallCommands = ''
    ln -s $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/1password.desktop $out/share/applications/1password.desktop
    substituteInPlace $out/share/applications/1password.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    homepage = "https://support.1password.com/cs/getting-started-linux/";
    description = "1Password for Linux is the simple, beautiful password manager you’ve been looking for.";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
