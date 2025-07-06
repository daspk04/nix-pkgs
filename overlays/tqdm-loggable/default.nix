{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,
  setuptools-scm,
  poetry-core,

  tqdm,
  ...
}:
buildPythonPackage rec {
  pname = "tqdm-loggable";
  version = "2.0-unstable-2024-10-11";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "tradingstrategy-ai";
    repo = "tqdm-loggable";
    rev = "0cea2d244416abad69b463365465bc7620e88c39";
    hash = "sha256-hjpGwmb2QQi/WCr+nY4PQvmRSGBoOAGvZWvsg7hCtw0=";
  };

  postPatch = ''
    substituteInPlace tqdm_loggable/tqdm_logging.py \
    --replace-fail 'from datetime import datetime, timedelta' 'from datetime import datetime, timedelta, UTC' \
    --replace-fail 'datetime.utcfromtimestamp(0)' 'datetime.fromtimestamp(0, UTC(0))'
  '';

  build-system = [
    setuptools
    setuptools-scm
    poetry-core
  ];

  dependencies = [
    tqdm
  ];

  pythonImportsCheck = [
    "tqdm_loggable.auto"
    "tqdm_loggable.tqdm_logging"
  ];

  meta = {
    description = "Logging friendly progress messages for TQDM progress bars";
    homepage = "https://github.com/tradingstrategy-ai/tqdm-loggable";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
