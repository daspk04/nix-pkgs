{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  # dependencies
  autogluon-core,
  autogluon-common,
  autogluon-features,
  autogluon-tabular,
  accelerate,
  #    coreforecast,
  #    fugue,
  #    gluonts,
  joblib,
  lightning,
  #    mlforecast,
  networkx,
  numpy,
  orjson,
  pandas,
  pytorch-lightning,
  scipy,
  #    statsforecast
  tensorboard,
  torch,
  transformers,
  tqdm,
  #    utilsforecast
  ...
}:
buildPythonPackage rec {
  pname = "autogluon-timeseries";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    tag = "v${version}";
    hash = "sha256-B5MkN5bZdqkPv+Jtzv67+bt5ZxfEsgFIe288+fSaUZM=";
  };

  sourceRoot = "${src.name}/timeseries/";

  build-system = [
    setuptools
  ];

  dependencies = [
    autogluon-core
    autogluon-common
    autogluon-features
    autogluon-tabular
    accelerate
    #    coreforecast
    #    fugue
    #    gluonts
    joblib
    lightning
    #    mlforecast
    networkx
    numpy
    orjson
    pandas
    pytorch-lightning
    scipy
    #    statsforecast
    tensorboard
    torch
    transformers
    tqdm
    #    utilsforecast
  ];

  pythonImportsCheck = [
    "autogluon.timeseries"
  ];

  meta = {
    description = "Fast and Accurate ML in 3 Lines of Code";
    homepage = "https://github.com/autogluon/autogluon/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
