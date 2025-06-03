{
  lib,
  fetchPypi,
  buildPythonPackage,
  pkgs,

  setuptools,
  setuptools-scm,
  poetry-core,

  cached-classproperty,
  pydantic,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "pydantic-duality";
  version = "2.0.2";
  format = "pyproject";
  docheck = false;

  src = fetchPypi {
    inherit version;
    pname = "pydantic_duality";
    hash = "sha256-dBYBD6Us7Tl9/skySk6m11ng79Gzo3sY3FWWVScJ7do=";
  };

  build-system = [
    setuptools
    setuptools-scm
    poetry-core
  ];

  dependencies = [
    cached-classproperty
    pydantic
    typing-extensions

  ];

  pythonImportsCheck = [
    "pydantic_duality"
  ];

  meta = {
    description = "Automatically and lazily generate three versions of your pydantic models";
    homepage = "https://github.com/zmievsa/pydantic-duality";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
