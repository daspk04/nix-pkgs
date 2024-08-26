{
  lib,
  fetchFromGitHub,
  pkgs,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "griffe";
  version = "1.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mkdocstrings";
    repo = "griffe";
    rev = "refs/tags/${version}";
    hash = "sha256-Iw5AATWVfaW5kIdTmW90aS7+nYcl/tQCrVJyRVrydHw=";
  };

  nativeBuildInputs = with pyPkgs; [
    pdm-backend
  ];

  propagatedBuildInputs = with pyPkgs; [
    colorama
    mkdocstrings
  ];

  pythonImportsCheck = ["griffe"];

  meta = with lib; {
    description = "Signatures for entire Python programs";
    homepage = "https://github.com/mkdocstrings/griffe";
    changelog = "https://github.com/mkdocstrings/griffe/blob/${version}/CHANGELOG.md";
    license = licenses.isc;
    maintainers = with maintainers; [daspk04];
    mainProgram = "griffe";
  };
}
