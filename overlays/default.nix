final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python312;
    enablePython = true;
    otb = prev.otb;
  };

  runpodctl = final.callPackage ./runpod/runpodctl/. { };

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {

      cached-classproperty = pyFinal.callPackage ./cached-classproperty/. { };

      cmocean = pyFinal.callPackage ./cmocean/. { };

      cursor = pyFinal.callPackage ./cursor/. { };

      datacrunch = pyFinal.callPackage ./datacrunch/. { };

      dstack = pyFinal.callPackage ./dstack/. {
         cursor = pyFinal.cursor;
         datacrunch = pyFinal.datacrunch;
         gpuhunt = pyFinal.gpuhunt;
         ignore-python = pyFinal.ignore-python;
         nebius = pyFinal.nebius;
         pydantic-duality = pyFinal.pydantic-duality;
      };

      # fixes to avoid collision with dask-image-2024.5.3
      google-auth-oauthlib = pyPrev.google-auth-oauthlib.overridePythonAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          rm -rf $out/${prev.python312.sitePackages}/docs/*
        '';
      });

      gpuhunt = pyFinal.callPackage ./gpuhunt/. { };

      ignore-python = pyFinal.callPackage ./ignore-python/. { };

      keras = pyPrev.keras.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      nebius = pyFinal.callPackage ./nebius/. { };

      optuna = pyPrev.optuna.overridePythonAttrs (_oldAttrs: {
        doCheck = false;
      });

      optuna-integration = pyFinal.callPackage ./optuna-integration/. {
        optuna = pyFinal.optuna;
      };

      otbtf = pyFinal.callPackage ./otbtf/. {
        keras = pyFinal.keras;
      };

      prefect = pyFinal.callPackage ./prefect/. { };

      pydantic-duality = pyFinal.callPackage ./pydantic-duality/. {
        cached-classproperty = pyFinal.cached-classproperty;
      };

      pyotb = pyFinal.callPackage ./pyotb/. { };

      pyinterp = pyFinal.callPackage ./pyinterp/. { };

      runpod = pyFinal.callPackage ./runpod/runpod-python/. {
        tqdm-loggable = pyFinal.tqdm-loggable;
      };

      skypilot = pyFinal.callPackage ./skypilot/. {
        runpod = pyFinal.runpod;
        nebius = pyFinal.nebius;
      };

      tensorflow = pyFinal.callPackage ./tensorflow/. {
        tensorflow = pyFinal.tensorflow-bin;
        python = final.python312;
      };

      torch = pyFinal.torch-bin;

      torchvision = pyFinal.torchvision-bin;

      tqdm-loggable = pyFinal.callPackage ./tqdm-loggable/. { };

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
