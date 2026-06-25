{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  rustPlatform,
  numpy,
}:
buildPythonPackage rec {
  pname = "chonkie-core";
  version = "0.10.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "chonkie-inc";
    repo = "chunk";
    tag = "v${version}";
    hash = "sha256-w/rsDdhkdFGsvwLNSVBTfL6Qo9Twh0Qa6EftltkM1FA=";
  };

  sourceRoot = "source/packages/python";

  postUnpack = ''
    cp source/Cargo.lock source/packages/python/Cargo.lock
  '';

  postPatch = ''
    chmod +w ../..
    chmod +w ../../Cargo.lock
  '';

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = "${src}/Cargo.lock";
  };

  dependencies = [
    numpy
  ];

  # Tests require network or complex setup, skipping for now as per project style
  doCheck = false;

  pythonImportsCheck = [
    "chonkie_core"
  ];

  meta = {
    description = "The fastest semantic text chunking library";
    homepage = "https://github.com/chonkie-inc/chunk";
    license = with lib.licenses; [
      mit
      asl20
    ];
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
