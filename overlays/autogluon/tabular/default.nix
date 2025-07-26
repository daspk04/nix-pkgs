{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  # dependencies
  autogluon-core,
  autogluon-features,
  networkx,
  numpy,
  pandas,
  scikit-learn,
  scipy,

  # optional dependencies
  catboost,
  fastai,
  lightgbm,
  ray,
  xgboost,
  ...
}:
buildPythonPackage rec {
  pname = "autogluon-tabular";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    tag = "v${version}";
    hash = "sha256-B5MkN5bZdqkPv+Jtzv67+bt5ZxfEsgFIe288+fSaUZM=";
  };

  sourceRoot = "${src.name}/tabular/";

  build-system = [
    setuptools
  ];

  dependencies = [
    autogluon-core
    autogluon-features
    networkx
    numpy
    pandas
    scikit-learn
    scipy
  ];

  optional-dependencies = lib.fix (_self: {

    all = [
      catboost
      fastai
      lightgbm
      ray
      xgboost
      # imodels
      # mitra
      # realmlp
      # skex
      # tabicl
      # tabm
      # tabpfn
      # tabpfnmix
    ];
  });

  pythonImportsCheck = [
    "autogluon.tabular"
  ];

  meta = {
    description = "Fast and Accurate ML in 3 Lines of Code";
    homepage = "https://github.com/autogluon/autogluon/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
