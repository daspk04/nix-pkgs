{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,
  optuna,
  ...
}:
buildPythonPackage rec {
  pname = "optuna-integration";
  version = optuna.version;
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "optuna";
    repo = "optuna-integration";
    tag = "v${version}";
    hash = "sha256-r3H3bb5M5laVACMSNm7bdpfOR6/qGkxBoi5Sa3G8vY0=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    optuna
  ];

  pythonImportsCheck = [
    "optuna_integration"
  ];

  meta = {
    description = "Extended functionalities for Optuna in combination with third-party libraries.";
    homepage = "https://optuna-integration.readthedocs.io/en/latest/index.html";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
