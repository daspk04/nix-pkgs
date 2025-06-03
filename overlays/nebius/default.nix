{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  setuptools,

    certifi,
    cryptography,
    grpcio,
    grpcio-status,
    protobuf,
    pyjwt,
    pyyaml,
  ...
}:
buildPythonPackage rec {
  pname = "nebius";
  version = "0.2.34";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "nebius";
    repo = "pysdk";
    tag = "v${version}";
    hash = "sha256-5S2AfWTjCJx/DtDX9Yieg/C0/83xNla5z6D2HYJEWKc=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    certifi
    cryptography
    grpcio
    grpcio-status
    protobuf
    pyjwt
    pyyaml
  ];

  pythonImportsCheck = [
    "nebius"
  ];

  meta = {
    description = "Nebius Python SDK";
    homepage = "https://github.com/nebius/pysdk";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
