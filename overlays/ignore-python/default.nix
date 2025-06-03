{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchPypi,
  breakpointHook,


  # build-system
  pkg-config,
  rustc,
  rustPlatform,

}:

buildPythonPackage rec {
  pname = "ignore-python";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "ignore_python";
    hash = "sha256-jGxmEls3V5mgGXPMlRkx8JrIfBhwBefET+nLnBIa+Vc=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
   inherit src version pname;
    hash = "sha256-22OmxjfTp+L5fwekNLCF6wel8TR3drM5g4FyWyc4PRA=";
  };

  nativeBuildInputs =
  [
    pkg-config
    rustc
  ] ++ (
    with rustPlatform;
    [
      cargoSetupHook
      maturinBuildHook
    ]);

  pythonImportsCheck = [
    "ignore"
  ];

  meta = {
    description = "Rust ignore crate Python bindings";
    homepage = "https://github.com/borsattoz/ignore-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}