{
  lib,
  pyPkgs,
  rioxarray,
  cmocean,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "xcube";
  version = "1.6.0";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/xcube-dev/xcube.git";
    ref = "refs/tags/v${version}";
    rev = "5319215a06e88aabda98d1f2788cf1690372db77";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs =
    with pyPkgs;
    [
      botocore
      cftime
      click
      dask
      dask-image
      deprecated
      distributed
      fiona
      fsspec
      gdal
      geopandas
      jdcal
      jsonschema
      mashumaro
      matplotlib
      netcdf4
      numba
      numpy
      oauthlib
      pandas
      pillow
      pyjwt
      pyproj
      pyyaml
      rasterio
      requests
      requests-oauthlib
      rfc3339-validator
      s3fs
      shapely
      tornado
      urllib3
      xarray
      zarr
      cmocean
    ]
    ++ [ rioxarray ];

  pythonImportsCheck = [
    "xcube"
  ];

  meta = {
    description = "xcube is a Python package for generating and exploiting data cubes powered by xarray, dask, and zarr.
    It has been designed in the context of Earth Observation data.";
    homepage = "https://github.com/dcs4cop/xcube";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
