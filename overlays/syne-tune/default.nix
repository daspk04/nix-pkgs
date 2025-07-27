{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  # dependencies
  dill,
  numpy,
  pandas,
  sortedcontainers,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "syne-tune";
  version = "0.14.2";

  src = fetchFromGitHub {
    owner = "syne-tune";
    repo = "syne-tune";
    tag = "v${version}";
    hash = "sha256-51QyfJ0XOcXTeE95YOhtUmhat23joaEYvUnk7hYfksY=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    dill
    numpy
    pandas
    sortedcontainers
    typing-extensions
  ];

  pythonImportsCheck = [
    "syne_tune"
  ];

  meta = {
    description = "Hyperparameter Optimization Library";
    homepage = "https://github.com/syne-tune/syne-tune";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
