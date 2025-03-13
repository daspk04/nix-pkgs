{
  odc-geo,
  lib,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "odc-stac";
  version = "0.3.10";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/opendatacube/odc-stac.git";
    ref = "refs/tags/v${version}";
    rev = "cf7b897eadd352d46c96ba80625a7a94e9823b6f";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    odc-geo
    xarray
    numpy
    dask
    pandas
    affine
    rasterio
    toolz
    pystac
    pystac-client
  ];

  pythonImportsCheck = [
    "odc.stac"
  ];

  meta = {
    description = "Tooling for converting STAC metadata to ODC data model";
    homepage = "https://github.com/opendatacube/odc-stac/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
