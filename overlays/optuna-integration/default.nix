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
    hash = "sha256-/S0ifB9DCVHYG5+3DNHq3vRa2VHOE4wLXHSi6wzqbFE=";
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
