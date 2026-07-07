{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  jupyter-core,
  jupyter-client,
  jupyter-mimetypes,
  requests,
  traitlets,
  typing-extensions,
  websocket-client,
  ...
}:
buildPythonPackage rec {
  pname = "jupyter-kernel-client";
  version = "0.9.0";
  pyproject = true;
  doCheck = false;

  src = fetchFromGitHub {
    owner = "datalayer";
    repo = "jupyter-kernel-client";
    rev = "2dd9bd837075354ad39508bf933b97f758284afc";
    hash = "sha256-y14PUkL0jJnaWqqFRAsv5TESCPqqS9LQd/MlzmYzqHA=";
  };

  build-system = [ hatchling ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
  '';

  dependencies = [
    jupyter-core
    jupyter-client
    jupyter-mimetypes
    requests
    traitlets
    typing-extensions
    websocket-client
  ];

  pythonImportsCheck = [ "jupyter_kernel_client" ];

  meta = {
    description = "Jupyter Kernel Client through websocket";
    homepage = "https://github.com/datalayer/jupyter-kernel-client";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}