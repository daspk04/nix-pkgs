{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  setuptools,

  # dependencies
  boto3,
  joblib,
  numpy,
  packaging,
  pandas,
  psutil,
  pyarrow,
  requests,
  s3fs,
  tqdm,
  typing-extensions,

  ...
}:
buildPythonPackage rec {
  pname = "autogluon-common";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "autogluon";
    repo = "autogluon";
    tag = "v${version}";
    hash = "sha256-B5MkN5bZdqkPv+Jtzv67+bt5ZxfEsgFIe288+fSaUZM=";
  };

  sourceRoot = "${src.name}/common/";

  postPatch = ''
    substituteInPlace setup.py --replace-fail 'version = ag.update_version(version, use_file_if_exists=False, create_file=True)' 'version = "${version}"'
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    boto3
    joblib
    numpy
    packaging
    pandas
    psutil
    pyarrow
    requests
    s3fs
    tqdm
    typing-extensions
  ];

  pythonImportsCheck = [
    "autogluon.common"
  ];

  meta = {
    description = "Fast and Accurate ML in 3 Lines of Code";
    homepage = "https://github.com/autogluon/autogluon/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
