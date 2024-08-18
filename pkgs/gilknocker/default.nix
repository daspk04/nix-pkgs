{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  format = "pyproject";
  pname = "gilknocker";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "milesgranger";
    repo = "gilknocker";
    rev = "v${version}";
    sha256 = "sha256-AK0CWOkTkcG1PXm40jh4YrDgP/iBKlbSNebiEQRs3mo=";
  };

  cargoDeps = pkgs.rustPlatform.fetchCargoTarball {
    inherit src pname version;

    name = "${pname}-${version}";
    hash = "sha256-zDg+aYsHR28SCOmiswDx8tD3VbcubgHoMbZsJ3NQhyk=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    rustc
    rustPlatform.maturinBuildHook
    rustPlatform.cargoSetupHook
  ];

  buildInputs = with pkgs;
    lib.optionals stdenv.isDarwin [
      libiconv
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  pythonImportsCheck = [
    "gilknocker"
  ];

  build-system = [
    pkgs.rustPlatform.maturinBuildHook
  ];

  meta = {
    description = "Knock on the Python GIL, determine how busy it is.";
    homepage = "https://github.com/milesgranger/gilknocker";
    license = [lib.licenses.mit lib.licenses.unlicense];
    maintainers = with lib.maintainers; [daspk04];
  };
}
