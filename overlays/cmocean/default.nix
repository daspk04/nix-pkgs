{
  lib,
  buildPythonPackage,
  numpy,
  matplotlib,
  setuptools,
  #  pyPkgs,
  pkgs,
  ...
}:
buildPythonPackage rec {
  pname = "cmocean";
  version = "4.0.3";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/matplotlib/cmocean.git";
    ref = "refs/tags/v${version}";
    rev = "59c35002c3aa5296b65d9646e52604c627441eb6";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    matplotlib
  ];

  pythonImportsCheck = [
    "cmocean"
  ];
  meta = {
    description = "Beautiful colormaps for oceanography";
    homepage = "https://matplotlib.org/cmocean/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
