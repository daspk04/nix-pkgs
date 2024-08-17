{
  lib,
  fetchFromGitHub,
  pystac,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "pystac-client";
  version = "0.8.3";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/stac-utils/pystac-client.git";
    ref = "refs/tags/v${version}";
    rev = "b65b325d31019025faa17b32584c81967cbcc9e2";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    requests
    pystac
  ];
  pythonImportsCheck = ["pystac_client"];

  meta = {
    description = "Python library for working with Spatiotemporal Asset Catalog (STAC)";
    homepage = "https://github.com/stac-utils/pystac-client.git";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [daspk04];
  };
}
