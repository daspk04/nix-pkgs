{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  pycasbin,
  sqlalchemy,
  setuptools,
  pytestCheckHook,
}:
buildPythonPackage rec {
  pname = "sqlalchemy-adapter";
  version = "1.9.0";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "officialpycasbin";
    repo = "sqlalchemy-adapter";
    tag = "v${version}";
    hash = "sha256-FjxRSJ+3IIdtKkpZvkL/KzH7gn4IJjCTchABglfcyQ4=";
  };

  build-system = [
    setuptools
  ];

  postPatch = ''
    sed -i 's/casbin/pycasbin/' requirements.txt
  '';

  dependencies = [
    pycasbin
    sqlalchemy
  ];

  pythonImportsCheck = [
    "sqlalchemy_adapter"
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "SQLAlchemy Adapter for PyCasbin";
    homepage = "https://github.com/officialpycasbin/sqlalchemy-adapter";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
