{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,
  setuptools-scm,

  aiohttp,
  aiohttp-retry,
  backoff,
  boto3,
  click,
  colorama,
  cryptography,
  fastapi,
  paramiko,
  prettytable,
  py-cpuinfo,
  inquirerpy,
  requests,
  tomli,
  tomlkit,
  tqdm-loggable,
  urllib3,
  watchdog,
  ...
}:
buildPythonPackage rec {
  pname = "runpod";
  version = "1.7.10";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "runpod";
    repo = "runpod-python";
    tag = version;
    hash = "sha256-33gYS7DcHvj3k++HK7HsaGZaD+Ttx2g5VPB8s7/IZD0=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies =
    [
      aiohttp
      aiohttp-retry
      backoff
      boto3
      click
      colorama
      cryptography
      fastapi
      paramiko
      prettytable
      py-cpuinfo
      inquirerpy
      requests
      tomli
      tomlkit
      tqdm-loggable
      urllib3
      watchdog
    ]
    ++ aiohttp.optional-dependencies.speedups
    ++ fastapi.optional-dependencies.all;

  pythonImportsCheck = [
    "runpod"
  ];

  meta = {
    description = "Python library for RunPod API and serverless worker SDK.";
    homepage = "https://github.com/runpod/runpod-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
