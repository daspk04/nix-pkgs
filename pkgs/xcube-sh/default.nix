{
  xcube,
  lib,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "xcube-sh";
  version = "0.11.0-dev";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/daspk04/xcube-sh.git";
    ref = "add-feature-processing-kwargs";
    rev = "b29cd3cfa1e25379857dd7ddb183211101dd892b";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    click
    numcodecs
    numpy
    oauthlib
    pandas
    psutil
    pyproj
    requests
    requests-oauthlib
    xarray
    xcube
    zarr
  ];

  pythonImportsCheck = [
    "xcube_sh"
  ];

  meta = {
    description = "An xcube plugin to allow generating data cubes from the Sentinel Hub Cloud API";
    homepage = "https://github.com/xcube-dev/xcube-sh";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [daspk04];
  };
}
