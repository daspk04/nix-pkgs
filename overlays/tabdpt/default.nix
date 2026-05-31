{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
  pythonRelaxDepsHook,

  faiss,
  huggingface-hub,
  numpy,
  omegaconf,
  safetensors,
  scikit-learn,
  scipy,
  torch,
  tqdm,
}:
buildPythonPackage rec {
  pname = "tabdpt";
  version = "1.1.14";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-sCpndqr070jWNAWM9C1tqFSRexg65qJggdKzGRciGZU=";
  };

  build-system = [
    setuptools
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail "faiss-cpu" "faiss"
  '';

  pythonRelaxDeps = [
    "faiss"
  ];

  dependencies = [
    faiss
    huggingface-hub
    numpy
    omegaconf
    safetensors
    scikit-learn
    scipy
    torch
    tqdm
  ];

  # Tests likely require model downloads
  doCheck = false;

  pythonImportsCheck = [
    "tabdpt"
  ];

  meta = {
    description = "TabDPT: Scaling Tabular Foundation Models on Real Data";
    homepage = "https://github.com/layer6ai-labs/TabDPT-inference";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
