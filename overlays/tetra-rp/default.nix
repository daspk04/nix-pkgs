{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  cloudpickle,
  runpod,
  pydantic,
  python-dotenv,
  ...
}:
buildPythonPackage rec {
  pname = "tetra-rp";
  version = "0.11.0";
  pyproject = true;
  docheck = false;

  src = fetchFromGitHub {
    owner = "runpod";
    repo = "tetra-rp";
    tag = "v${version}";
    hash = "sha256-ZwdOKSrTGX4QFqMETAu7y68YTUCzeRhlPF8fS+Sv3U8=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    cloudpickle
    runpod
    pydantic
    python-dotenv
  ];

  pythonImportsCheck = [
    "tetra_rp"
  ];

  meta = {
    description = "Python SDK for serverless computing for AI workloads on Runpod";
    homepage = "https://github.com/runpod/tetra-rp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
