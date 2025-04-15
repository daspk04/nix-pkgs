final: prev: {
  otb = final.callPackage ./otb/. {
    python3 = final.python312;
    enablePython = true;
    itk = final.callPackage ./itk/. { };
  };
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {
      cmocean = pyFinal.callPackage ./cmocean/. { };
      coolname = pyFinal.callPackage ./coolname/. { };

      # https://github.com/dask/distributed/pull/8962
      distributed = pyPrev.distributed.overridePythonAttrs (oldAttrs: {
        patches = oldAttrs.patches or [ ] ++ [
          (prev.fetchpatch {
            url = "https://github.com/dask/distributed/commit/3ef88b3668b9a5a5f121109f3bc20c5c621d3d45.diff";
            hash = "sha256-RJgRaiiDjmTrI0Nfye7iX/RjF3BrrbPZgeJAWs5tXvM=";
          })
          (prev.fetchpatch {
            url = "https://github.com/dask/distributed/commit/0657de24bee9eff3f79e175f684853798f8b0c58.diff";
            hash = "sha256-0p/wHJDxnNNOpXDfl1yZOId727sCZEiP5fMHJtJBufg=";
          })
        ];
      });

      gilknocker = pyFinal.callPackage ./gilknocker/. { };

      # fixes to avoid collision with dask-image-2024.5.3
      google-auth-oauthlib = pyPrev.google-auth-oauthlib.overridePythonAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
          rm -rf $out/${prev.python312.sitePackages}/docs/*
        '';
      });

      jinja2-humanize-extension = pyFinal.callPackage ./jinja2-humanize-extension/. { };

      keras = pyPrev.keras.overridePythonAttrs (oldAttrs: {
        dependencies = oldAttrs.dependencies or [ ] ++ [ pyPrev.distutils ];
      });

      odc-geo = pyFinal.callPackage ./odc-geo/. { };
      pyotb = pyFinal.callPackage ./pyotb/. { };
      rclone-python = pyFinal.callPackage ./rclone-python/. { };
      rio-stac = pyFinal.callPackage ./rio-stac/. { };
      rioxarray = pyFinal.callPackage ./rioxarray/. { };
      verde = pyFinal.callPackage ./verde/. { };

      coiled = pyFinal.callPackage ./coiled/. {
        gilknocker = pyFinal.gilknocker;
      };

      odc-stac = pyFinal.callPackage ./odc-stac/. {
        odc-geo = pyFinal.odc-geo;
      };

      otbtf = pyFinal.callPackage ./otbtf/. {
        keras = pyFinal.keras;
      };

      planetary-computer = pyFinal.callPackage ./planetary-computer/. {
      };

      prefect = pyFinal.callPackage ./prefect/. {
        coolname = pyFinal.coolname;
        jinja2-humanize-extension = pyFinal.jinja2-humanize-extension;
      };

      tensorflow = pyFinal.callPackage ./tensorflow/. {
        tensorflow = pyFinal.tensorflow-bin;
        python = final.python312;
      };

      # https://github.com/NixOS/nixpkgs/issues/351717
      triton-bin = pyPrev.triton-bin.overridePythonAttrs (oldAttrs: {
        postFixup = ''
          chmod +x "$out/${prev.python312.sitePackages}/triton/backends/nvidia/bin/ptxas"
          substituteInPlace $out/${prev.python312.sitePackages}/triton/backends/nvidia/driver.py \
            --replace \
              'return [libdevice_dir, *libcuda_dirs()]' \
              'return [libdevice_dir, "${prev.addDriverRunpath.driverLink}/lib", "${prev.cudaPackages.cuda_cudart}/lib/stubs/"]'
        '';
      });

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
