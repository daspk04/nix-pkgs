final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python312;
    enablePython = true;
    otb = prev.otb;
  };

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {

      cmocean = pyFinal.callPackage ./cmocean/. { };

      # fixes to avoid collision with dask-image-2024.5.3
      google-auth-oauthlib = pyPrev.google-auth-oauthlib.overridePythonAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          rm -rf $out/${prev.python312.sitePackages}/docs/*
        '';
      });

      keras = pyPrev.keras.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });

      pyotb = pyFinal.callPackage ./pyotb/. { };
      rclone-python = pyFinal.callPackage ./rclone-python/. { };
      rio-stac = pyFinal.callPackage ./rio-stac/. { };
      rioxarray = pyFinal.callPackage ./rioxarray/. { };
      verde = pyFinal.callPackage ./verde/. { };

      optuna = pyPrev.optuna.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });

      otbtf = pyFinal.callPackage ./otbtf/. {
        keras = pyFinal.keras;
      };

      tensorflow = pyFinal.callPackage ./tensorflow/. {
        tensorflow = pyFinal.tensorflow-bin;
        python = final.python312;
      };

      torch = pyFinal.torch-bin;

      torchvision = pyFinal.torchvision-bin;

      xcube = pyFinal.callPackage ./xcube/. {
        rioxarray = pyFinal.rioxarray;
        cmocean = pyFinal.cmocean;
      };

      xcube-sh = pyFinal.callPackage ./xcube-sh/. {
        xcube = pyFinal.xcube;
      };
    })
  ];
}
