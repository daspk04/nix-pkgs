{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "coolname";
  version = "latest";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/alexanderlukanin13/coolname.git";
    ref = "master";
    rev = "86d6e813e30c9282eaa8bffddceb95d821e84e26";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  meta = {
    description = "Random Name and Slug Generator";
    homepage = "https://github.com/alexanderlukanin13/coolname";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
