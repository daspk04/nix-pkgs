{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
  wheel,

  torch,
  numpy,
  scikit-learn,
  typing-extensions,
  scipy,
  pandas,
  einops,
  huggingface-hub,
  pydantic,
  pydantic-settings,
  eval-type-backport,
  joblib,
  tqdm,
  filelock,
  lightgbm,
  tabpfn-common-utils,
}:
buildPythonPackage rec {
  pname = "tabpfn";
  version = "8.0.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Q7uLobPb5E3ZrRT9y7cAwIMJL95cniCUMTs1+hs1Rqg=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    torch
    numpy
    scikit-learn
    typing-extensions
    scipy
    pandas
    einops
    huggingface-hub
    pydantic
    pydantic-settings
    eval-type-backport
    joblib
    tqdm
    filelock
    lightgbm
    tabpfn-common-utils
  ];

  # Tests require model downloads or GPU
  doCheck = false;

  pythonImportsCheck = [
    "tabpfn"
  ];

  meta = {
    description = "TabPFN: Foundation Model for Tabular Data";
    homepage = "https://github.com/prior-labs/tabpfn";
    license = lib.licenses.asl20; # Code is Apache 2.0; weights have separate license but this is just the package
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
