{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  cloudpickle,
  rich,
  runpod,
  pydantic,
  python-dotenv,
  questionary,
  typer,
  ...
}:
buildPythonPackage rec {
  pname = "tetra-rp";
  version = "0.13.0";
  pyproject = true;
  docheck = false;

  src = fetchFromGitHub {
    owner = "runpod";
    repo = "tetra-rp";
    tag = "v${version}";
    hash = "sha256-BgHFjcLJgbmqP5kN08c2ttQjMvR0UJHcJJRlP3Z8RqY=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    cloudpickle
    rich
    runpod
    pydantic
    python-dotenv
    questionary
    typer
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
