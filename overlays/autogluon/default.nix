{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  # common deps
  numpy,
  pandas,
  pyarrow,
  boto3,
  psutil,
  tqdm,
  requests,
  joblib,
  pyyaml,
  packaging,
  typing-extensions,

  # core deps
  scipy,
  scikit-learn,
  networkx,
  matplotlib,

  # optional deps (for extras_require in setup.py)
  lightgbm,
  xgboost,
  catboost,
  ray,
  fastai,

  # obscure extras support (where available in nixpkgs; others like scikit-learn-intelex are blocked by heavy native dependencies oneDAL/daal4py)
  skl2onnx,
  onnx,
  onnxruntime,
  einops,
  loguru,
  einx,
  omegaconf,
  transformers,
  imodels,
  interpret-core,
  pytabkit,
  tabicl,
  tabdpt,
  tabpfn,

  # for tests
  pytestCheckHook,
}:

let
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    rev = "v${version}";
    hash = "sha256-A4nl0hiy5s+dXfp+N5iygxjwPavkwQDz+IBo8QRyD8Q=";
  };

  commonPkg = buildPythonPackage {
    pname = "autogluon-common";
    inherit version src;
    format = "setuptools";

    preBuild = ''
      cd common
    '';

    dependencies = [
      numpy
      pandas
      pyarrow
      boto3
      psutil
      tqdm
      requests
      joblib
      pyyaml
      packaging
      typing-extensions
    ];

    doCheck = false;

    nativeCheckInputs = [
      pytestCheckHook
    ];

    pytestFlagsArray = [
      "--runslow"
      "-m" "not platform"
    ];

    pythonImportsCheck = [
      "autogluon.common"
    ];

    meta = {
      description = "AutoGluon common utilities";
      homepage = "https://github.com/autogluon/autogluon";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ daspk04 ];
    };
  };

  corePkg = buildPythonPackage {
    pname = "autogluon-core";
    inherit version src;
    format = "setuptools";

    preBuild = ''
      cd core
    '';

    dependencies = [
      commonPkg
      numpy
      scipy
      scikit-learn
      networkx
      pandas
      tqdm
      requests
      matplotlib
      boto3
    ];

    doCheck = false;

    nativeCheckInputs = [
      pytestCheckHook
    ];

    pytestFlagsArray = [
      "--runslow"
      "-m" "not platform"
    ];

    pythonImportsCheck = [
      "autogluon.core"
    ];

    passthru = {
      optional-dependencies = {
        ray = [ ray ];
        raytune = [ ray ];
      };
    };

    meta = {
      description = "AutoGluon core functionality for hyperparameter tuning";
      homepage = "https://github.com/autogluon/autogluon";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ daspk04 ];
    };
  };

  featuresPkg = buildPythonPackage {
    pname = "autogluon-features";
    inherit version src;
    format = "setuptools";

    preBuild = ''
      cd features
    '';

    dependencies = [
      commonPkg
      numpy
      pandas
      scikit-learn
    ];

    doCheck = false;

    nativeCheckInputs = [
      pytestCheckHook
    ];

    pytestFlagsArray = [
      "--runslow"
      "-m" "not platform"
    ];

    pythonImportsCheck = [
      "autogluon.features"
    ];

    meta = {
      description = "AutoGluon feature engineering utilities";
      homepage = "https://github.com/autogluon/autogluon";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ daspk04 ];
    };
  };

  tabularPkg = buildPythonPackage {
    pname = "autogluon-tabular";
    inherit version src;
    format = "setuptools";

    preBuild = ''
      cd tabular
    '';

    dependencies = [
      commonPkg
      corePkg
      featuresPkg
      numpy
      scipy
      pandas
      scikit-learn
      networkx
    ];

    doCheck = false;

    pythonImportsCheck = [
      "autogluon.tabular"
    ];

    passthru = {
      optional-dependencies = {
        lightgbm = [ lightgbm ];
        catboost = [ catboost ];
        xgboost = [ xgboost ];
        ray = [ ray ];
        fastai = [ fastai ];
        skl2onnx = [
          skl2onnx
          onnx
          onnxruntime
        ];
        mitra = [
          loguru
          einx
          omegaconf
          transformers
        ];
        tabpfnmix = [
          einops
        ];
        imodels = [ imodels ];
        interpret = [ interpret-core ];
        realmlp = [ pytabkit ];
        tabpfn = [ tabpfn ];
        tabdpt = [ tabdpt ];
        tabicl = [ tabicl ];
        # tabm only requires torch (already in core deps)
        # "all" and "tabarena" combos (defined per tabular/setup.py); only using pkgs available in nixpkgs.
        # Remaining obscure extras (scikit-learn-intelex, skex) omitted -- blocked by missing native dependencies oneDAL and daal4py (not available in nixpkgs).
        all = [
          lightgbm
          catboost
          xgboost
          fastai
          ray
          loguru
          einx
          omegaconf
          transformers
          imodels
          interpret-core
          pytabkit
          tabpfn
          tabdpt
          tabicl
        ];
        tabarena = [
          lightgbm
          catboost
          xgboost
          fastai
          ray
          loguru
          einx
          omegaconf
          transformers
          imodels
          interpret-core
          pytabkit
          tabpfn
          tabdpt
          tabicl
          # + etc. (not yet available in nixpkgs)
        ];
      };
    };

    meta = {
      description = "AutoGluon tabular machine learning";
      homepage = "https://github.com/autogluon/autogluon";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ daspk04 ];
    };
  };

in
{
  autogluon-common = commonPkg;
  autogluon-core = corePkg;
  autogluon-features = featuresPkg;
  autogluon-tabular = tabularPkg;
}