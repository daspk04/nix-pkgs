{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "rclone-python";
  version = "0.1.12-unstable-2024-09-09";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "Johannes11833";
    repo = "rclone_python";
    rev = "c2bd48c99f08d748e4e749abfcec07739c9776ec";
    hash = "sha256-0ZarLXMwbNO+mer8lWTqwWXERqvqLtIGtr56QwT9OnM=";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    rich
  ];

  meta = {
    description = "rclone python wrapper";
    homepage = "https://github.com/Johannes11833/rclone_python.git";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
