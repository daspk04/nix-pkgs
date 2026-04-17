{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  rustPlatform,
  ...
}:
let
  common = import ./common.nix { inherit fetchFromGitHub; };
in
buildPythonPackage rec {
  inherit (common) pname version src sourceRoot;
  pyproject = true;
  docheck = false;

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = "${src}/Cargo.lock";
  };

  pythonImportsCheck = [
    "pdf_oxide"
  ];

  meta = {
    description = "Python bindings for the pdf_oxide Rust PDF library";
    homepage = "https://github.com/yfedoseev/pdf_oxide";
    license = with lib.licenses; [
      mit
      asl20
    ];
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
