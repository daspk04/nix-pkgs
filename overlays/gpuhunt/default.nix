{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  setuptools,

  requests,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "gpuhunt";
  version = "0.1.6";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "dstackai";
    repo = "gpuhunt";
    tag = version;
    hash = "sha256-2f+HWUCdWObJfbQMip8bBmfTnsH99VYGXbrIGqPNV9Q=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    requests
    typing-extensions
  ];

  pythonImportsCheck = [
    "gpuhunt"
  ];

  meta = {
    description = "GPU prices aggregator for cloud providers";
    homepage = "https://github.com/dstackai/gpuhunt";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
