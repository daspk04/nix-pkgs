final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {
      cmocean = pyFinal.callPackage ./cmocean/. { };
      coolname = pyFinal.callPackage ./coolname/. { };
      gilknocker = pyFinal.callPackage ./gilknocker/. { };
      jinja2-humanize-extension = pyFinal.callPackage ./jinja2-humanize-extension/. { };
      otbtf = pyFinal.callPackage ./otbtf/. { };
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

      planetary-computer = pyFinal.callPackage ./planetary-computer/. {
      };

      prefect = pyFinal.callPackage ./prefect/. {
        coolname = pyFinal.coolname;
        jinja2-humanize-extension = pyFinal.jinja2-humanize-extension;
      };

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
