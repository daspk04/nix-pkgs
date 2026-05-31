{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,

  numpy,
  pandas,
  psutil,
  pytorch-lightning,
  scikit-learn,
  torch,
  torchmetrics,
}:
buildPythonPackage rec {
  pname = "pytabkit";
  version = "1.7.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dholzmueller";
    repo = "pytabkit";
    rev = "v${version}";
    hash = "sha256-TYsNsAb7LdtMtAexNVUVtHUlE0zM7Q/8M+H8B4ivAe4=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    torch
    numpy
    pandas
    scikit-learn
    torchmetrics
    pytorch-lightning
    psutil
  ];

  # Upstream has a large optional-deps matrix and some tests rely on GPU / network / OpenML.
  doCheck = false;

  pythonImportsCheck = [
    "pytabkit"
  ];

  meta = {
    description = "ML models + benchmark for tabular data classification and regression";
    homepage = "https://github.com/dholzmueller/pytabkit";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
