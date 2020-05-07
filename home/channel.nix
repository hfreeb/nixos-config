let home-manager = (builtins.fetchTarball {
    url = "https://github.com/rycee/home-manager/archive/a378bccd609c159fa8d421233b9c5eae04f02042.tar.gz"; # 2020-05-01
    sha256 = "1cfh0aj60qriadvn5xvsp24p1xr06g68m3pfvzwahv2bd2cg261r";
  });
in import "${home-manager}/nixos"
