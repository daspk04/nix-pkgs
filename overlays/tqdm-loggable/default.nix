{
  lib,
  fetchFromGitHub,
  fetchpatch,
  buildPythonPackage,
  pkgs,

  setuptools,
  setuptools-scm,
  poetry-core,

  tqdm,
  ...
}:
buildPythonPackage rec {
  pname = "tqdm-loggable";
  version = "2.0-unstable-2024-10-11";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "tradingstrategy-ai";
    repo = "tqdm-loggable";
    rev = "0cea2d244416abad69b463365465bc7620e88c39";
    hash = "sha256-hjpGwmb2QQi/WCr+nY4PQvmRSGBoOAGvZWvsg7hCtw0=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/tradingstrategy-ai/tqdm-loggable/pull/8.patch";
      hash = "sha256-jNEhZWBj6mAcimqL1TydEGPVqkPiRnLlh7O2ykqtO0I=";
    })
  ];

  build-system = [
    setuptools
    setuptools-scm
    poetry-core
  ];

  dependencies = [
    tqdm
  ];

  pythonImportsCheck = [
    "tqdm_loggable"
  ];

  meta = {
    description = "Logging friendly progress messages for TQDM progress bars";
    homepage = "https://github.com/tradingstrategy-ai/tqdm-loggable";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
