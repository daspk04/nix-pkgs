{
  description = "A flake for nixpkgs";

  inputs = {
    nixpkgs.follows = "nixpkgs-release";
    flake-utils.url = "github:numtide/flake-utils";
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs-nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-release.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-release,
    nixpkgs-nixpkgs-unstable,
    nixpkgs-nixos-unstable,
    nix2container,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        unstablePkgs = nixpkgs-nixos-unstable.legacyPackages.${system};
        nix2containerPkgs = nix2container.packages.${system};
        python312 = pkgs.python312;
        python312-latest = unstablePkgs.python312;

        python311 = pkgs.python311;
        python311-latest = unstablePkgs.python311;

        python = python311-latest;
        pyPkgs = python.pkgs;
      in rec {
        packages = {
          inherit python python311 python311-latest python312 python312-latest unstablePkgs;
          cmocean = pkgs.callPackage ./pkgs/cmocean/. {
            inherit system pyPkgs pkgs;
          };
          coiled = pkgs.callPackage ./pkgs/coiled/. {
            inherit system pyPkgs;
            gilknocker = packages.gilknocker;
          };
          coolname = pkgs.callPackage ./pkgs/coolname/. {
            inherit system pyPkgs;
          };
          gilknocker = pkgs.callPackage ./pkgs/gilknocker/. {
            inherit system pyPkgs;
          };
          griffe = pkgs.callPackage ./pkgs/griffe/. {
            inherit system pyPkgs pkgs;
          };
          jinja2-humanize-extension = pkgs.callPackage ./pkgs/jinja2-humanize-extension/. {
            inherit system pyPkgs;
          };
          odc-geo = pkgs.callPackage ./pkgs/odc-geo/. {
            inherit system pyPkgs;
          };
          odc-stac = pkgs.callPackage ./pkgs/odc-stac/. {
            inherit system pyPkgs;
            pystac = packages.pystac;
            pystac-client = packages.pystac-client;
            odc-geo = packages.odc-geo;
          };
          planetary-computer = pkgs.callPackage ./pkgs/planetary-computer/. {
            inherit system pyPkgs;
            pystac = packages.pystac;
            pystac-client = packages.pystac-client;
          };
          pyotb = pkgs.callPackage ./pkgs/pyotb/. {inherit system pyPkgs;};
          prefect = pkgs.callPackage ./pkgs/prefect/. {
            inherit system pyPkgs;
            coolname = packages.coolname;
            jinja2-humanize-extension = packages.jinja2-humanize-extension;
            griffe = packages.griffe;
          };
          pystac = pkgs.callPackage ./pkgs/pystac/. {inherit system pyPkgs;};
          pystac-client = pkgs.callPackage ./pkgs/pystac-client/. {
            inherit system pyPkgs;
            pystac = packages.pystac;
          };
          rclone-python = pkgs.callPackage ./pkgs/rclone-python/. {
            inherit system pyPkgs;
          };
          rio-stac = pkgs.callPackage ./pkgs/rio-stac/. {
            inherit system pyPkgs;
            pystac = packages.pystac;
          };
          rioxarray = pkgs.callPackage ./pkgs/rioxarray/. {
            inherit system pyPkgs;
          };
          verde = pkgs.callPackage ./pkgs/verde/. {
            inherit system pyPkgs;
          };
          xcube = pkgs.callPackage ./pkgs/xcube/. {
            inherit system pyPkgs;
            rioxarray = packages.rioxarray;
            cmocean = packages.cmocean;
          };

          xcube-sh = pkgs.callPackage ./pkgs/xcube-sh/. {
            inherit system pyPkgs;
            xcube = packages.xcube;
          };

          coiledEnv = pkgs.buildEnv {
            name = "coiled-env";
            paths = with pyPkgs;
              [dask distributed tornado cloudpickle msgpack bokeh s3fs]
              ++ [packages.coiled packages.prefect];
          };

          geoEnv = pkgs.buildEnv {
            name = "geo-env";
            paths = [pyPkgs.gdal];
          };

          geomlEnv = pkgs.buildEnv {
            name = "geoml-env";
            paths = [packages.verde];
          };

          otbEnv = pkgs.buildEnv {
            name = "otb-env";
            paths = with packages; [geoEnv pyotb];
          };

          geoxrEnv = pkgs.buildEnv {
            name = "geoxr-env";
            paths = with packages; [rioxarray odc-stac odc-geo];
          };

          stacEnv = pkgs.buildEnv {
            name = "stac-env";
            paths = with packages; [pystac pystac-client planetary-computer rio-stac];
          };

          xcubeEnv = pkgs.buildEnv {
            name = "xcube-env";
            paths = with packages; [xcube xcube-sh];
          };

          miscEnv = pkgs.buildEnv {
            name = "misc-env";
            paths = with packages; [rclone-python];
          };

          allPkgsEnv = pkgs.buildEnv {
            name = "allPkgs-env";
            paths = with packages; [coiledEnv geoEnv geomlEnv geoxrEnv otbEnv stacEnv xcubeEnv miscEnv];
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
      }
    );
}
