{
  lib,
  fetchFromGitHub,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "odc-geo";
  version = "0.4.8";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/opendatacube/odc-geo.git";
    ref = "refs/tags/v${version}";
    rev = "aad1a619e0e258ca6e55c4301efe9905ab927c7c";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    affine
    cachetools
    pyproj
    numpy
    shapely
    xarray
  ];

  pythonImportsCheck = [
    "odc.geo
    odc.geo.xr"
  ];

  meta = {
    description = "This library combines geometry shape classes from `shapely` with CRS from
    `pyproj` to provide a number of data types and utilities useful for working
    with geospatial metadata and geo-registered `xarray` rasters.";
    homepage = "https://github.com/opendatacube/odc-geo/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [daspk04];
  };
}
