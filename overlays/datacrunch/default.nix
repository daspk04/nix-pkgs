{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  setuptools,

    certifi,
    charset-normalizer,
    dataclasses-json,
    idna,
    mypy-extensions,
    packaging,
    requests,
    typing-inspect,
    typing-extensions,
    urllib3,
  ...
}:
buildPythonPackage rec {
  pname = "datacrunch";
  version = "1.13.1";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "DataCrunch-io";
    repo = "datacrunch-python";
    tag = "v${version}";
    hash = "sha256-Wmd7P6C5xbg77OGZ7dKdm+9TMRyyHrPIdH4FVWJbbmA=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    certifi
    charset-normalizer
    dataclasses-json
    idna
    mypy-extensions
    packaging
    requests
    typing-inspect
    typing-extensions
    urllib3
  ];

  pythonImportsCheck = [
    "datacrunch"
  ];

  meta = {
    description = "DataCrunch.io Python SDK";
    homepage = "https://github.com/dstackai/gpuhunt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
