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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      # deadnix: skip
      nixpkgs-unstable,
      # deadnix: skip
      nix2container,
      flake-utils-plus,
      treefmt-nix,
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

      channels.nixpkgs.overlaysBuilder = _channels: [
        (_final: _prev: {
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
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        rec {
          packages = {
            python = python;
            inherit (pyPkgs)
              cmocean
              google-auth-oauthlib
              keras
              nebius
              optuna
              optuna-integration
              otbtf
              prefect
              pyinterp
              pyotb
              runpod
              skypilot
              torch
              torchvision
              tensorflow
              tqdm-loggable
              verde
              xcube
              xcube-sh
              ;
            inherit (pkgs)
              otb
              runpodctl
              ;

            cloudEnv = pkgs.buildEnv {
              name = "cloudEnv";
              paths = [
                packages.runpod
                packages.runpodctl
                packages.skypilot
              ];
            };

            coiledEnv = pkgs.buildEnv {
              name = "coiled-env";
              paths = with pyPkgs; [
                bokeh
                cloudpickle
                coiled
                dask
                distributed
                msgpack
                prefect
                s3fs
                tornado
              ];
            };

            collisionEnv = pkgs.buildEnv {
              name = "collision-env";
              paths = [
                pyPkgs.dask-image
                packages.google-auth-oauthlib
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
                packages.pyinterp
              ];
            };

            mlEnv = pkgs.buildEnv {
              name = "ml-env";
              paths =
                with pyPkgs;
                [
                  onnxruntime
                  optuna
                  optuna-integration
                  ray
                  polars
                  pyarrow
                  pytorch-lightning
                ]
                ++ ray.optional-dependencies.air
                ++ (with packages; [
                  keras
                  torch
                  tensorflow
                ]);
            };

            otbEnv = pkgs.buildEnv {
              name = "otb-env";
              paths = with packages; [
                geoEnv
                pyotb
                otbtf
              ];
            };

            otbDevEnv = pkgs.buildEnv {
              name = "otbDev-env";
              paths = with packages; [
                (otb.override {
                  enablePython = true;
                  enablePrefetch = true;
                  enableOtbtf = true;
                  enableMLUtils = true;
                  # enableNormlimSigma0 = true;
                  enablePhenology = true;
                  # enableRTCGamma0 = true;
                  enableBioVars = true;
                  enableGRM = true;
                  # enableLSGRM = true;
                  enableSimpleExtraction = true;
                  enableTemporalGapfilling = true;
                  enableTimeSeriesUtils = true;
                  enableTemporalSmoothing = true;
                  enableTf = true;
                  tensorflow = packages.tensorflow;
                })
              ];
            };

            geoxrEnv = pkgs.buildEnv {
              name = "geoxr-env";
              paths = with pyPkgs; [
                rioxarray
                odc-stac
                odc-geo
              ];
            };

            stacEnv = pkgs.buildEnv {
              name = "stac-env";
              paths = with pyPkgs; [
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
              paths = with pyPkgs; [ rclone-python ];
            };

            allPkgsEnv = pkgs.buildEnv {
              name = "allPkgs-env";
              paths = with packages; [
                cloudEnv
                collisionEnv
                coiledEnv
                geoEnv
                geomlEnv
                geoxrEnv
                # mlEnv
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
            # required environment for otbtf-gpu (otbtf build with cuda)
            #            postShellHook = ''
            #              export CUDA_PATH=${pkgs.cudatoolkit}
            #              export XLA_FLAGS="--xla_gpu_cuda_data_dir=${pkgs.cudatoolkit}"
            #              export LD_LIBRARY_PATH="${pkgs.cudatoolkit}/lib:${pkgs.cudatoolkit}/nvvm/libdevice:/run/opengl-driver/lib/$LD_LIBRARY_PATH"
            #            '';
          };
          # for `nix fmt`
          formatter = treefmtEval.config.build.wrapper;
          # for `nix flake check`
          checks.formatting = treefmtEval.config.build.check self;

        };
    };
}
