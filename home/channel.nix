let home-manager = (builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042"; # 2020-05-01
    ref = "release-20.03";
  });
in import "${home-manager}/nixos"
