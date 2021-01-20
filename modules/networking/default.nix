{ config, lib, ... }:
{
  networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];

  # Generate read-only resolv.conf to stop dhcpcd appending to it.
  environment.etc."resolv.conf".text = ''
    ${lib.concatStringsSep "\n"
    (map (ns: "nameserver ${ns}") config.networking.nameservers)}
    options edns0
  '';
}
