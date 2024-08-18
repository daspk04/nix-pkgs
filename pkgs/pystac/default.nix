{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "pystac";
  version = "1.10.1";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/stac-utils/pystac.git";
    ref = "refs/tags/v${version}";
    rev = "c2de7ca14ccdddb7960e816ac8ac599d4e2e5906";
  };
  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    python-dateutil
  ];
  pythonImportsCheck = ["pystac"];

  meta = {
    description = "Python library for working with Spatiotemporal Asset Catalog (STAC)";
    homepage = "https://github.com/stac-utils/pystac";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [daspk04];
  };
}
