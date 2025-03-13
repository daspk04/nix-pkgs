{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "pyotb";
  version = "2.1.0";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "orfeotoolbox";
    repo = "pyotb";
    rev = "refs/tags/${version}";
    hash = "sha256-KomIMVx4jfsTSbGtoml9ON/82sHanOkp/mp1TiUaa2E=";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    numpy
  ];

  meta = {
    description = "pyotb is a Python extension of Orfeo Toolbox.
    It has been built on top of the existing Python API of OTB, in order to make OTB more Python friendly.";
    homepage = "https://github.com/orfeotoolbox/pyotb";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
