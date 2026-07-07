{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  click,
  filelock,
  google-auth,
  google-auth-oauthlib,
  html2text,
  jupyter-kernel-client,
  nbformat,
  packaging,
  prompt-toolkit,
  pydantic,
  pygments,
  requests,
  rich,
  typer,
  typing-extensions,
  websocket-client,
  ...
}:
buildPythonPackage rec {
  pname = "google-colab-cli";
  version = "0.6.0";
  pyproject = true;
  doCheck = false;

  src = fetchFromGitHub {
    owner = "googlecolab";
    repo = "google-colab-cli";
    tag = "v${version}";
    hash = "sha256-pnt4TzrFTRg3RCUzYCPreX9a4LykVg/f1WwEumzzeU8=";
  };

  build-system = [ hatchling ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
    substituteInPlace pyproject.toml --replace-fail 'requires = ["hatchling", "hatch-vcs"]' 'requires = ["hatchling"]'
    substituteInPlace pyproject.toml --replace-fail $'[tool.hatch.version]\nsource = "vcs"\n' ""
  '';

  dependencies = [
    click
    filelock
    google-auth
    google-auth-oauthlib
    html2text
    jupyter-kernel-client
    nbformat
    packaging
    prompt-toolkit
    pydantic
    pygments
    requests
    rich
    typer
    typing-extensions
    websocket-client
  ];

  pythonRelaxDeps = [
    "filelock"
    "typer"
  ];

  pythonImportsCheck = [ "colab_cli" ];

  meta = {
    description = "CLI for interacting with Google Colab";
    homepage = "https://github.com/googlecolab/google-colab-cli";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "colab";
  };
}