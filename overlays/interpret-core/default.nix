{
  lib,
  fetchPypi,
  buildPythonPackage,

  joblib,
  numpy,
  pandas,
  scikit-learn,
}:
buildPythonPackage rec {
  pname = "interpret-core";
  version = "0.7.8";
  format = "setuptools";

  src = fetchPypi {
    pname = "interpret_core";
    inherit version;
    hash = "sha256-OVEqSjlx1HyS9QyX9DSqYDqxRJqtbZTwmh0cByp43aU=";
  };

  dependencies = [
    numpy
    pandas
    scikit-learn
    joblib
  ];

  # Test suite pulls in heavy/GUI/browser deps (selenium/jupyter/etc.); keep checks minimal.
  doCheck = false;

  pythonImportsCheck = [
    "interpret"
  ];

  meta = {
    description = "Fit interpretable models. Explain blackbox machine learning";
    homepage = "https://github.com/interpretml/interpret";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
