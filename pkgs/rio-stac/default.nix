{
  lib,
  fetchFromGitHub,
  pystac,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "rio-stac";
  version = "0.9.0";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/developmentseed/rio-stac.git";
    ref = "refs/tags/${version}";
    rev = "52a13eec0c8ad19dee904b2bc0cd529b73b95899";
  };

  nativeBuildInputs = with pyPkgs; [
    flit
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    rasterio
    pystac
  ];

  meta = {
    description = "rio-stac is a simple rasterio plugin for creating valid STAC items from a raster dataset.
    The library is built on top of pystac to make sure we follow the STAC specification.";
    homepage = "https://developmentseed.org/rio-stac/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [daspk04];
  };
}
