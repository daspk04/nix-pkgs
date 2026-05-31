final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python313;
    enablePython = true;
    otb = prev.otb;
  };

  pdf-oxide = final.callPackage ./pdf-oxide/. { };

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {

      autogluon-common = (pyFinal.callPackage ./autogluon/. { }).autogluon-common;
      autogluon-core = (pyFinal.callPackage ./autogluon/. { }).autogluon-core;
      autogluon-features = (pyFinal.callPackage ./autogluon/. { }).autogluon-features;
      autogluon-tabular = (pyFinal.callPackage ./autogluon/. { }).autogluon-tabular;


      botorch = pyPrev.botorch.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      cmocean = pyFinal.callPackage ./cmocean/. { };

      chonkie-core = pyFinal.callPackage ./chonkie-core/. { };

      chonkie = pyFinal.callPackage ./chonkie/. {
        chonkie-core = pyFinal.chonkie-core;
      };

      gpytorch = pyPrev.gpytorch.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      imodels = pyFinal.callPackage ./imodels/. { };

      interpret-core = pyFinal.callPackage ./interpret-core/. { };

      keras = pyPrev.keras.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      linear-operator = pyPrev.linear-operator.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      nebius = pyFinal.callPackage ./nebius/. { };

      notebooklm-py = pyFinal.callPackage ./notebooklm-py/. { };

      optuna = pyPrev.optuna.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      optuna-integration = pyFinal.callPackage ./optuna-integration/. {
        optuna = pyFinal.optuna;
      };

      optunahub = pyFinal.callPackage ./optunahub/. { };

      otbtf = pyFinal.callPackage ./otbtf/. {
        keras = pyFinal.keras;
      };

      prefect = pyFinal.callPackage ./prefect/. { };

      pyotb = pyFinal.callPackage ./pyotb/. { };

      pytabkit = pyFinal.callPackage ./pytabkit/. { };

      pdf_oxide = pyFinal.callPackage ./pdf-oxide/python.nix { };

      runpod = pyFinal.callPackage ./runpod/runpod-python/. {
        tqdm-loggable = pyFinal.tqdm-loggable;
      };

      skorch = pyPrev.skorch.overridePythonAttrs (_oldAttrs: {
        disabled = false;
        disabledTests = (_oldAttrs.disabledTests or [ ]) ++ [
          "test_binary_classifier_with_compile"
        ];
        patches = (_oldAttrs.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/skorch-dev/skorch/pull/1082.patch";
            hash = "sha256-ThsvbTrBruuRNUlay03mnzmknHgcTF9gA6M9JTgM8/w=";
          })
        ];
      });

      skypilot = pyFinal.callPackage ./skypilot/. {
        runpod = pyFinal.runpod;
        nebius = pyFinal.nebius;
        inherit (final) buildNpmPackage;
      };

      sqlalchemy-adapter = pyFinal.callPackage ./sqlalchemy-adapter/. { };

      syne-tune = pyPrev.syne-tune.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      tabicl = pyFinal.callPackage ./tabicl/. { };

      tabdpt = pyFinal.callPackage ./tabdpt/. { };

      tabpfn-common-utils = pyFinal.callPackage ./tabpfn-common-utils/. { };

      tabpfn = pyFinal.callPackage ./tabpfn/. { };


      tensorflow = pyFinal.callPackage ./tensorflow/. {
        tensorflow = pyPrev.tensorflow;
        python = final.python313;
      };

      tetra-rp = pyFinal.callPackage ./tetra-rp/. { };

      torch = pyPrev.torch;

      torchvision = pyPrev.torchvision;

      tqdm-loggable = pyFinal.callPackage ./tqdm-loggable/. { };

      types-paramiko = pyFinal.callPackage ./types-paramiko/. { };

      verde = pyFinal.callPackage ./verde/. { };

      vastai = pyFinal.callPackage ./vastai/. { };

      xcube = pyFinal.callPackage ./xcube/. {
        cmocean = pyFinal.cmocean;
      };

      xcube-sh = pyFinal.callPackage ./xcube-sh/. {
        xcube = pyFinal.xcube;
      };
    })
  ];
}
