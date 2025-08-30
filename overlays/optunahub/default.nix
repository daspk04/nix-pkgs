{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,
  optuna,
  gitpython,
  pygithub,
  ...
}:
buildPythonPackage rec {
  pname = "optunahub";
  version = "0.3.1";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "optuna";
    repo = "optunahub";
    tag = "v${version}";
    hash = "sha256-s5iO4jPZTHvCfBFdB6ytfbPeCe9+CUek8ZYUPWRYVJ4=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    optuna
    gitpython
    pygithub
  ];

  pythonImportsCheck = [
    "optunahub"
  ];

  meta = {
    description = "Python library to use packages in OptunaHub";
    homepage = "https://github.com/optuna/optunahub";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
