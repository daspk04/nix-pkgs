final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python312;
    enablePython = true;
    otb = prev.otb;
  };

  runpodctl = final.callPackage ./runpod/runpodctl/. { };

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

      # https://note.com/198619891990/n/na832c57019a2,
      # https://github.com/protocolbuffers/protobuf/issues/11863#issuecomment-1433881846
      protobuf = pyPrev.protobuf.overridePythonAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          cat >> $out/lib/python*/site-packages/google/protobuf/message_factory.py << 'EOF'

          # TensorFlow compatibility patch
          if not hasattr(MessageFactory, 'GetPrototype'):
              def GetPrototype(self, descriptor):
                  return self.GetMessageClass(descriptor)
              MessageFactory.GetPrototype = GetPrototype
          EOF
        '';
      });

      pyotb = pyFinal.callPackage ./pyotb/. { };

      pyinterp = pyFinal.callPackage ./pyinterp/. { };

      runpod = pyFinal.callPackage ./runpod/runpod-python/. {
        tqdm-loggable = pyFinal.tqdm-loggable;
      };

      skypilot = pyFinal.callPackage ./skypilot/. {
        runpod = pyFinal.runpod;
        nebius = pyFinal.nebius;
      };

      # `ImportError: cannot import name 'notf`
      tensorboard = pyPrev.tensorboard.overridePythonAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          substituteInPlace $out/${prev.python312.sitePackages}/tensorboard/compat/__init__.py \
            --replace-fail 'from tensorboard.compat import notf  # noqa: F401' 'pass'
        '';
      });

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
