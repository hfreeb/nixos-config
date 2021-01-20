self: super: {
 jetbrains = super.jetbrains // {
    idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs (
      oldAttrs: rec {
        version = "2020.3.1";
        src = super.fetchurl {
          url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
          sha256 = "YFOk9Pziw8BcGr4KvArTepOHV6F0MfoTgRPo0E2bIxs=";
        };
      }
    );
  };
}
