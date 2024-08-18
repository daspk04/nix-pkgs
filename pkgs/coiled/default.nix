{
  lib,
  gilknocker,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "coiled";
  version = "1.40.0";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-hDwHnqqsAVHB+ThTjxHp4T+gU1tZ3odwMC7FDGsyiiA=";
  };

  nativeBuildInputs = with pyPkgs; [
    hatchling
    hatch-vcs
  ];

  propagatedBuildInputs = with pyPkgs; [
    aiohttp
    backoff
    bokeh
    boto3
    click
    dask
    distributed
    fabric
    filelock
    gilknocker
    httpx
    importlib-metadata
    invoke
    ipywidgets
    jmespath
    jsondiff
    paramiko
    pip-requirements-parser
    pip
    prometheus_client
    rich
    toml
    setuptools
    typing-extensions
    wheel
  ];

  pythonImportsCheck = ["coiled"];

  meta = {
    description = "A Python package to easily create, manage, and connect to Dask deployments
    using Coiled Cloud.";
    homepage = "https://docs.coiled.io";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [daspk04];
  };
}
