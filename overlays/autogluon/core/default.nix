{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  autogluon-common,

  # dependencies
  boto3,
  joblib,
  matplotlib,
  networkx,
  numpy,
  pandas,
  psutil,
  pyarrow,
  requests,
  scikit-learn,
  scipy,
  tqdm,

  # optional deps
  ray,

  ...
}:
buildPythonPackage rec {
  pname = "autogluon-core";
  version = "1.3.1";

  # source doesn't have dashboard artifacts outputs needs to build them via npm
  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    tag = "v${version}";
    hash = "sha256-B5MkN5bZdqkPv+Jtzv67+bt5ZxfEsgFIe288+fSaUZM=";
  };

  sourceRoot = "${src.name}/core/";

  build-system = [
    setuptools
  ];

  dependencies = [
    boto3
    joblib
    matplotlib
    networkx
    numpy
    pandas
    psutil
    pyarrow
    requests
    scikit-learn
    scipy
    tqdm
    autogluon-common
  ];

  optional-dependencies = lib.fix (_self: {

    all = [
      ray
      ray.optional-dependencies.tune
    ];
  });

  pythonImportsCheck = [
    "autogluon.core"
  ];

  meta = {
    description = "Fast and Accurate ML in 3 Lines of Code";
    homepage = "https://github.com/autogluon/autogluon/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
