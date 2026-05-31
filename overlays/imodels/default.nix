{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  matplotlib,
  mlxtend,
  numpy,
  pandas,
  requests,
  scipy,
  scikit-learn,
  tqdm,
}:
buildPythonPackage rec {
  pname = "imodels";
  version = "2.3.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "csinva";
    repo = "imodels";
    rev = "v${version}";
    hash = "sha256-zAiPMPnG/JkAHdswIt6gjj8583uaLG9ZkjUbcftlrKQ=";
  };

  postPatch = ''
    cat > fix.py <<EOF
def indices_to_mask(indices, mask_length):
    import numpy as np
    mask = np.zeros(mask_length, dtype=bool)
    mask[indices] = True
    return mask
EOF
    sed -i '/from sklearn.utils import indices_to_mask/r fix.py' imodels/util/score.py
    sed -i '/from sklearn.utils import indices_to_mask/d' imodels/util/score.py
  '';

  dependencies = [
    matplotlib
    mlxtend
    numpy
    pandas
    requests
    scipy
    scikit-learn
    tqdm
  ];

  doCheck = false;

  pythonImportsCheck = [
    "imodels"
  ];

  meta = {
    description = "Implementations of various interpretable models";
    homepage = "https://github.com/csinva/imodels";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
