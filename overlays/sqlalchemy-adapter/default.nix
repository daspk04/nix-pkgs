{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  casbin,
  sqlalchemy,
  setuptools,
  ...
}:
buildPythonPackage rec {
  pname = "sqlalchemy-adapter";
  version = "1.3.0";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "officialpycasbin";
    repo = "sqlalchemy-adapter";
    tag = "v${version}";
    hash = "sha256-/t+4YFfrV20zy6enaL1rBrj2G06z2y71ogaN8MeLFcQ=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    casbin
    sqlalchemy
  ];

  pythonImportsCheck = [
    "sqlalchemy_adapter"
  ];

  meta = {
    description = "SQLAlchemy Adapter for PyCasbin";
    homepage = "https://github.com/officialpycasbin/sqlalchemy-adapter";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
