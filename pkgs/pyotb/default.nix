{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "pyotb";
  version = "2.0.3.dev2";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/orfeotoolbox/pyotb.git";
    ref = "refs/tags/${version}";
    rev = "de801eae7e2bd80706801df4a48b23998136a5cd";
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
    maintainers = with lib.maintainers; [daspk04];
  };
}
