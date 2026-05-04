{
  lib,
  fetchFromGitHub,
  rustPlatform,
  versionCheckHook,
  ...
}:
let
  common = import ./common.nix { inherit fetchFromGitHub; };
in
rustPlatform.buildRustPackage rec {
  inherit (common)
    pname
    version
    src
    sourceRoot
    ;

  cargoBuildFlags = [
    "-p"
    "pdf_oxide_cli"
    "-p"
    "pdf_oxide_mcp"
    "--bins"
  ];

  cargoHash = "sha256-0Z1fR6unzOvQZSwuUmjAgGt2EZOCJ40kjmk/gsgKjjQ=";
  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  meta = {
    description = "CLI and MCP binaries from the pdf_oxide workspace";
    homepage = "https://github.com/yfedoseev/pdf_oxide";
    license = with lib.licenses; [
      mit
      asl20
    ];
    mainProgram = "pdf-oxide";
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
