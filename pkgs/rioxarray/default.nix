{
  lib,
  fetchFromGitHub,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "rioxarray";
  version = "0.17.0";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/corteva/rioxarray.git";
    ref = "refs/tags/${version}";
    rev = "6303bb673e95cd2a752a675f78cea5be84ce675c";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    numpy
    packaging
    pyproj
    rasterio
    xarray
  ];

  pythonImportsCheck = [
    "rioxarray"
  ];
  meta = {
    description = "Python library for rasterio xarray extension.";
    homepage = "http://github.com/corteva/rioxarray";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
