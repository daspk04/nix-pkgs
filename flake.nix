{
  description = "A flake for nixpkgs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.flake-utils.follows = "flake-utils-plus";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix2container,
      flake-utils-plus,
    }@inputs:

    flake-utils-plus.lib.mkFlake {

      inherit self inputs;
      channelsConfig = {
        allowUnfree = true;
      };

      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: {
          python312 = prev.python312.override {
            packageOverrides = final: prevPy: {
              tensorflow = prevPy.tensorflow-bin;
              keras = prevPy.keras.overridePythonAttrs (oldAttrs: {
                dependencies = oldAttrs.dependencies or [ ] ++ [ prevPy.distutils ];
              });
            };
          };
          python312Packages = final.python312.pkgs;
        })
      ];

      outputsBuilder =
        channels:
        let
          pkgs = channels.nixpkgs;
          python = channels.nixpkgs.python312;
          pyPkgs = python.pkgs;
          nix2containerPkgs = nix2container.packages.${self.host.system};
        in
        rec {
          packages = {
            python = python;
            cmocean = pkgs.callPackage ./pkgs/cmocean/. {
              inherit pyPkgs pkgs;
            };
            coiled = pkgs.callPackage ./pkgs/coiled/. {
              inherit pyPkgs;
              gilknocker = packages.gilknocker;
            };
            coolname = pkgs.callPackage ./pkgs/coolname/. {
              inherit pyPkgs;
            };
            gilknocker = pkgs.callPackage ./pkgs/gilknocker/. {
              inherit pyPkgs;
            };
            jinja2-humanize-extension = pkgs.callPackage ./pkgs/jinja2-humanize-extension/. {
              inherit pyPkgs;
            };
            odc-geo = pkgs.callPackage ./pkgs/odc-geo/. {
              inherit pyPkgs;
            };
            odc-stac = pkgs.callPackage ./pkgs/odc-stac/. {
              inherit pyPkgs;
              odc-geo = packages.odc-geo;
            };
            otbtf = pkgs.callPackage ./pkgs/otbtf/. {
              inherit pyPkgs;
            };
            planetary-computer = pkgs.callPackage ./pkgs/planetary-computer/. {
              inherit pyPkgs;
              pystac = packages.pystac;
              pystac-client = packages.pystac-client;
            };
            pyotb = pkgs.callPackage ./pkgs/pyotb/. {
              inherit pyPkgs;
            };
            prefect = pkgs.callPackage ./pkgs/prefect/. {
              inherit pyPkgs;
              coolname = packages.coolname;
              jinja2-humanize-extension = packages.jinja2-humanize-extension;
            };
            rclone-python = pkgs.callPackage ./pkgs/rclone-python/. {
              inherit pyPkgs;
            };
            rio-stac = pkgs.callPackage ./pkgs/rio-stac/. {
              inherit pyPkgs;
            };
            rioxarray = pkgs.callPackage ./pkgs/rioxarray/. {
              inherit pyPkgs;
            };
            verde = pkgs.callPackage ./pkgs/verde/. {
              inherit pyPkgs;
            };
            xcube = pkgs.callPackage ./pkgs/xcube/. {
              inherit pyPkgs;
              rioxarray = packages.rioxarray;
              cmocean = packages.cmocean;
            };

            xcube-sh = pkgs.callPackage ./pkgs/xcube-sh/. {
              inherit pyPkgs;
              xcube = packages.xcube;
            };

            coiledEnv = pkgs.buildEnv {
              name = "coiled-env";
              paths =
                with pyPkgs;
                [
                  dask
                  distributed
                  tornado
                  cloudpickle
                  msgpack
                  bokeh
                  s3fs
                ]
                ++ [
                  packages.coiled
                  packages.prefect
                ];
            };

            geoEnv = pkgs.buildEnv {
              name = "geo-env";
              paths = [ pyPkgs.gdal ];
            };

            geomlEnv = pkgs.buildEnv {
              name = "geoml-env";
              paths = [
                packages.verde
              ];
            };

            otbEnv = pkgs.buildEnv {
              name = "otb-env";
              paths = with packages; [
                geoEnv
                pyotb
                otbtf
              ];
            };

            geoxrEnv = pkgs.buildEnv {
              name = "geoxr-env";
              paths = with packages; [
                rioxarray
                odc-stac
                odc-geo
              ];
            };

            stacEnv = pkgs.buildEnv {
              name = "stac-env";
              paths = with packages; [
                planetary-computer
                rio-stac
              ];
            };

            xcubeEnv = pkgs.buildEnv {
              name = "xcube-env";
              paths = with packages; [
                xcube
                xcube-sh
              ];
            };

            miscEnv = pkgs.buildEnv {
              name = "misc-env";
              paths = with packages; [ rclone-python ];
            };

            allPkgsEnv = pkgs.buildEnv {
              name = "allPkgs-env";
              paths = with packages; [
                coiledEnv
                geoEnv
                geomlEnv
                geoxrEnv
                otbEnv
                stacEnv
                xcubeEnv
                miscEnv
              ];
            };
          };
          devShells.default = pkgs.mkShell rec {
            packages = with pkgs; [
              bashInteractive
              pyPkgs.python
              pyPkgs.venvShellHook
              skopeo
            ];
            venvDir = "./.venv";
          };
        };
    };
}
