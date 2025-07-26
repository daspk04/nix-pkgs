{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  # dependencies
  autogluon-common,
  numpy,
  pandas,
  scikit-learn,
  ...
}:
buildPythonPackage rec {
  pname = "autogluon-features";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    tag = "v${version}";
    hash = "sha256-B5MkN5bZdqkPv+Jtzv67+bt5ZxfEsgFIe288+fSaUZM=";
  };

  sourceRoot = "${src.name}/features/";

  build-system = [
    setuptools
  ];

  dependencies = [
    autogluon-common
    numpy
    pandas
    scikit-learn
  ];

  pythonImportsCheck = [
    "autogluon.features"
  ];

  meta = {
    description = "Fast and Accurate ML in 3 Lines of Code";
    homepage = "https://github.com/autogluon/autogluon/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
