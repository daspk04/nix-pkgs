final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python313;
    enablePython = true;
    otb = prev.otb;
  };

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {

      botorch = pyPrev.botorch.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });

      cmocean = pyFinal.callPackage ./cmocean/. { };

      gpytorch = pyPrev.gpytorch.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });

      keras = pyPrev.keras.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      linear-operator = pyPrev.linear-operator.overridePythonAttrs (oldAttrs: {
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

      runpod = pyFinal.callPackage ./runpod/runpod-python/. {
        tqdm-loggable = pyFinal.tqdm-loggable;
      };

      skypilot = pyFinal.callPackage ./skypilot/. {
        runpod = pyFinal.runpod;
        nebius = pyFinal.nebius;
      };

      sqlalchemy-adapter = pyFinal.callPackage ./sqlalchemy-adapter/. { };

      tensorflow = pyFinal.callPackage ./tensorflow/. {
        tensorflow = pyFinal.tensorflow-bin;
        python = final.python313;
      };

      tetra-rp = pyFinal.callPackage ./tetra-rp/. { };

      torch = pyFinal.torch-bin;

      torchvision = pyFinal.torchvision-bin;

      tqdm-loggable = pyFinal.callPackage ./tqdm-loggable/. { };

      types-paramiko = pyFinal.callPackage ./types-paramiko/. { };

      verde = pyFinal.callPackage ./verde/. { };

      xcube = pyFinal.callPackage ./xcube/. {
        cmocean = pyFinal.cmocean;
      };

      xcube-sh = pyFinal.callPackage ./xcube-sh/. {
        xcube = pyFinal.xcube;
      };
    })
  ];
}
