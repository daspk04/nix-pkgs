{
  lib,
  fetchPypi,
  buildPythonPackage,
  pkgs,

  setuptools,
  setuptools-scm,
  poetry-core,
  ...
}:
buildPythonPackage rec {
  pname = "cached-classproperty";
  version = "1.1.0";
  format = "pyproject";
  docheck = false;

  src = fetchPypi {
    inherit version;
    pname = "cached_classproperty";
    hash = "sha256-8BKzFNanlycOurnfGxhpWW178S7DfX5g0Dl2Ikv7zv0=";
  };

  build-system = [
    setuptools
    setuptools-scm
    poetry-core
  ];

  pythonImportsCheck = [
    "cached_classproperty"
  ];

  meta = {
    homepage = "https://pypi.org/project/cached_classproperty";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
