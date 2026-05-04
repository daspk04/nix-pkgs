{ fetchFromGitHub }:
rec {
  pname = "pdf-oxide";
  version = "0.3.33";

  src = fetchFromGitHub {
    owner = "yfedoseev";
    repo = "pdf_oxide";
    tag = "v${version}";
    hash = "sha256-V+rbPTiRX7UUstNjKRUU7GyAiV3dTFWTg8Kjpdxz5kA=";
  };

  sourceRoot = "source";
}
