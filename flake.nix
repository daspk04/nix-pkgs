{
  description = "A flake for nixpkgs";

    nixConfig = {
      extra-substituters = [
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

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
    let
      inherit (flake-utils-plus.lib) exportOverlays;
    in
    flake-utils-plus.lib.mkFlake {

      inherit self inputs;
      channelsConfig = {
        allowUnfree = true;
        # enable for cuda packages
        # cudaSupport = true;
      };

      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: {
        })
      ];

      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      overlay = import ./overlays;
      sharedOverlays = [
        self.overlay
      ];

      overlays = exportOverlays {
        inherit (self) pkgs inputs;
      };

      outputsBuilder =
        channels:
        let
          pkgs = channels.nixpkgs;
          python = channels.nixpkgs.python312;
          pyPkgs = python.pkgs;
          nix2containerPkgs = nix2container.packages.${self.pkgs.system};
        in
        rec {
          packages = {
            python = python;
            inherit (pyPkgs)
              cmocean
              coiled
              coolname
              gilknocker
              jinja2-humanize-extension
              keras
              odc-geo
              odc-stac
              otbtf
              planetary-computer
              prefect
              pyotb
              rclone-python
              rio-stac
              rioxarray
              tensorflow
              verde
              xcube
              xcube-sh
              ;

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
                ++ (with packages; [
                  coiled
                  prefect
                ]);
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
              bump-my-version
            ];
            venvDir = "./.venv";
            postShellHook = ''
              export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/wsl/lib"
            '';
          };
        };
    };
}
