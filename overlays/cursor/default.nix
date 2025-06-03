{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  setuptools,
  setuptools-scm,
  poetry-core,
  ...
}:
buildPythonPackage rec {
  pname = "cursor";
  version = "1.3.5";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "GijsTimmers";
    repo = "cursor";
    tag = "v${version}";
    hash = "sha256-h05AYhhVeYzeF9En8SbpwNVmlNlZ9R+G2MkV+0AnQ8s=";
  };

  build-system = [
    setuptools
  ];

  pythonImportsCheck = [
    "cursor"
  ];

  meta = {
    description = "Package to hide or show the terminal cursor";
    homepage = "https://github.com/GijsTimmers/cursor";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
