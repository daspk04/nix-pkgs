{
  lib,
  fetchFromGitLab,
  buildPythonPackage,
  setuptools,
  gdal,
  keras,
  numpy,
  tqdm,
  ...
}:
buildPythonPackage rec {
  pname = "otbtf";
  version = "5.0.0";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitLab {
    owner = "orfeo-toolbox";
    repo = "otbtf";
    rev = version;
    hash = "sha256-6VqjuydvTmP+ES6xLQ8uSGTw/+ynYui+QkGXerYkZX8=";
    domain = "forgemia.inra.fr";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
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
