{
  lib,
  fetchPypi,
  buildPythonPackage,
  hatchling,

  torch,
  scikit-learn,
  numpy,
  scipy,
  einops,
  psutil,
  tqdm,
  huggingface-hub,
}:
buildPythonPackage rec {
  pname = "tabicl";
  version = "2.1.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-er2x+oeOeh7focZga/QYnpzMwgk16AEdfmkPRpPJxcU=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    torch
    scikit-learn
    numpy
    scipy
    einops
    psutil
    tqdm
    huggingface-hub
  ];

  # Tests likely require model downloads or GPU
  doCheck = false;

  pythonImportsCheck = [
    "tabicl"
  ];

  meta = {
    description = "TabICL: A state-of-the-art tabular foundation model";
    homepage = "https://github.com/prior-labs/tabicl"; # Verified from search
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
