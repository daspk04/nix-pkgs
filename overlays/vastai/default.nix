{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  poetry-core,
  xdg,
  borb,
  requests,
  python-dateutil,
  urllib3,
  pyparsing,
  aiohttp,
  aiodns,
  pycares,
  anyio,
  psutil,
  pycryptodome,
  argcomplete,
  curlify,
  rich,
  cryptography,
  ...
}:
buildPythonPackage rec {
  pname = "vastai";
  version = "1.0.8";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "vast-ai";
    repo = "vast-cli";
    tag = "v${version}";
    hash = "sha256-/J+5TdS+GkmiuVcYBESDCCHC5xCakEpsfujPktMVB6I=";
  };

  build-system = [
    poetry-core
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'requires = ["poetry-core>=1.0.0", "poetry-dynamic-versioning>=1.0.0,<2.0.0"]' 'requires = ["poetry-core>=1.0.0"]' \
      --replace-fail 'build-backend = "poetry_dynamic_versioning.backend"' 'build-backend = "poetry.core.masonry.api"' \
      --replace-fail 'version = "0.0.0"' 'version = "${version}"' \
      --replace-fail 'dynamic = ["version"]' ' ' \
      --replace-fail 'aiodns>=3.6.0' 'aiodns>=3.5.0' \
      --replace-fail 'pycares==4.11.0' 'pycares>=4.9.0' \
      --replace-fail 'psutil~=6.0' 'psutil>=6.0' \
      --replace-fail 'cryptography<=46.0.4' 'cryptography>=46.0.0'
  '';

  dependencies = [
    xdg
    borb
    requests
    python-dateutil
    urllib3
    pyparsing
    aiohttp
    aiodns
    pycares
    anyio
    psutil
    pycryptodome
    argcomplete
    curlify
    rich
    cryptography
  ];

  pythonImportsCheck = [
    "vastai"
    "vastai_sdk"
  ];

  meta = {
    description = "CLI and SDK for Vast.ai GPU Cloud Service";
    homepage = "https://github.com/vast-ai/vast-cli";
    license = lib.licenses.mit;
  };
}
