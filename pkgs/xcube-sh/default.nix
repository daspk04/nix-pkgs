{
  xcube,
  lib,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "xcube-sh";
  version = "0.11.0-unstable-2024-09-26";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/daspk04/xcube-sh.git";
    ref = "develop";
    rev = "49808c3cd91bee809f87cac24b2bbb2d591f5f4e";
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
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
