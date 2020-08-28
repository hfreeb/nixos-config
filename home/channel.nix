let home-manager = (builtins.fetchTarball {
    url = "https://github.com/rycee/home-manager/archive/4a8d6280544d9b061c0b785d2470ad6eeda47b02.tar.gz"; # 2020-08-26
    sha256 = "0m9zhp94ckzzxsgx5xdi374ndr3bh1d84344rncn9qzgnm2pzfj0";
  });
in import "${home-manager}/nixos"
