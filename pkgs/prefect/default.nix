{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  coolname,
  griffe,
  jinja2-humanize-extension,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "prefect";
  version = "2.20.3";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/PrefectHQ/prefect.git";
    ref = "refs/tags/${version}";
    rev = "b8c27aa06d9d3892cbb1d1d69e78e604a527adae";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "anyio"
    "exceptiongroup"
    "griffe"
    "uvicorn"
  ];

  propagatedBuildInputs = with pyPkgs;
    [
      aiosqlite
      alembic
      anyio
      apprise
      asgi-lifespan
      asyncpg
      click
      cloudpickle
      coolname
      croniter
      cryptography
      dateparser
      docker
      docker-py
      exceptiongroup
      fsspec
      graphviz
      httpcore
      httpx
      importlib-metadata
      importlib-resources
      itsdangerous
      jsonpatch
      jsonschema
      jinja2
      jinja2-humanize-extension
      orjson
      packaging
      pathspec
      kubernetes
      python-multipart
      pendulum
      pydantic
      pydantic-core
      python-dateutil
      python-slugify
      pytz
      pyyaml
      readchar
      rfc3339-validator
      rich
      ruamel-yaml
      sniffio
      sqlalchemy
      starlette
      toml
      typer
      typing-extensions
      ujson
      uvicorn
      websockets
    ]
    ++ [griffe];

  pythonImportsCheck = ["prefect"];

  meta = {
    description = "Prefect is a workflow orchestration framework for building resilient data pipelines in Python.";
    homepage = "https://www.prefect.io/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [daspk04];
  };
}
