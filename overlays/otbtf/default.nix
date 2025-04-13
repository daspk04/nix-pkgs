{
  lib,
  fetchFromGitHub,
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

  src = fetchFromGitHub {
    owner = "remicres";
    repo = "otbtf";
    tag = version;
    hash = "sha256-/UIQpaXJgQq3JOzibWHBlMqlBdp6lcNmMOv7hO0J2w4=";
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
