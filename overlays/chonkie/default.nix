{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  numpy,
  tqdm,
  chonkie-core,
  tenacity,
  httpx,
}:
buildPythonPackage rec {
  pname = "chonkie";
  version = "1.6.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "chonkie-inc";
    repo = "chonkie";
    tag = "v${version}";
    hash = "sha256-PU0V2w9NLsND6oxNqdSHc64J1Jm0o8F+aEwFrJTJl30=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    numpy
    tqdm
    chonkie-core
    tenacity
    httpx
  ];

  # Tests often require data or network
  doCheck = false;

  pythonImportsCheck = [
    "chonkie"
  ];

  meta = {
    description = "The lightweight ingestion library for fast, efficient and robust RAG pipelines";
    homepage = "https://github.com/chonkie-inc/chonkie";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
