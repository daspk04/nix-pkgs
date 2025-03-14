{
  lib,
  fetchFromGitLab,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "otbtf";
  version = "5.0.0rc4";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitLab {
    owner = "orfeo-toolbox";
    repo = "otbtf";
    rev = "${version}";
    hash = "sha256-OpiotQvFEYiYpY2ZCjF4zOnN+mTE4oof913BXBgfDAE=";
    domain = "forgemia.inra.fr";
  };

  build-system = with pyPkgs; [
    setuptools
  ];

  dependencies = with pyPkgs; [
    gdal
    keras
    numpy
    tqdm
  ];

  pythonImportsCheck = [
    "otbtf"
    "otbtf.dataset"
  ];

  meta = {
    description = "OTBTF python API to build and training Keras compliant models";
    homepage = "https://otbtf.readthedocs.io/en/latest/index.html";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
