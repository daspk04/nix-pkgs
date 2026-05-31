{
  lib,
  fetchPypi,
  buildPythonPackage,
  hatchling,
  hatch-vcs,
  pythonRelaxDepsHook,

  numpy,
  pandas,
  scikit-learn,
  typing-extensions,
  posthog,
  platformdirs,
  filelock,
  requests,
  nvidia-ml-py,
}:
buildPythonPackage rec {
  pname = "tabpfn-common-utils";
  version = "0.2.21";
  pyproject = true;

  src = fetchPypi {
    pname = "tabpfn_common_utils";
    inherit version;
    hash = "sha256-3E8AyKXnWfqRIQ6xmt/r4gHsSe3DVAdf5uZQMbD3YFM=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "nvidia-ml-py"
  ];

  dependencies = [
    numpy
    pandas
    scikit-learn
    typing-extensions
    posthog
    platformdirs
    filelock
    requests
    nvidia-ml-py
  ];

  # pure utility package, but tests might need network for posthog
  doCheck = false;

  pythonImportsCheck = [
    "tabpfn_common_utils"
  ];

  meta = {
    description = "Utilities shared between TabPFN codebases";
    homepage = "https://github.com/priorlabs/tabpfn_common_utils";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
