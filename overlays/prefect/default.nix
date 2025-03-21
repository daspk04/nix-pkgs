{
  lib,
  fetchFromGitHub,
  pkgs,
  buildPythonPackage,
  setuptools,
  pythonRelaxDepsHook,

  aiosqlite,
  alembic,
  anyio,
  apprise,
  asgi-lifespan,
  asyncpg,
  click,
  cloudpickle,
  coolname,
  croniter,
  cryptography,
  dateparser,
  docker,
  exceptiongroup,
  fsspec,
  graphviz,
  griffe,
  httpcore,
  httpx,
  h2,
  importlib-metadata,
  importlib-resources,
  itsdangerous,
  jsonpatch,
  jsonschema,
  jinja2,
  jinja2-humanize-extension,
  orjson,
  packaging,
  pathspec,
  kubernetes,
  python-multipart,
  pendulum,
  pydantic,
  pydantic-core,
  python-dateutil,
  python-slugify,
  pytz,
  pyyaml,
  readchar,
  rfc3339-validator,
  rich,
  ruamel-yaml,
  sniffio,
  sqlalchemy,
  starlette,
  toml,
  typer,
  typing-extensions,
  ujson,
  uvicorn,
  websockets,
  ...
}:
buildPythonPackage rec {
  pname = "prefect";
  version = "2.20.16";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "PrefectHQ";
    repo = "prefect";
    rev = version;
    sha256 = "sha256-UY4GypQVs8qXh/nhJlbCnoqGqSRkF775xFfBwasxKyU=";
  };

  nativeBuildInputs = [
    setuptools
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "anyio"
    "exceptiongroup"
    "griffe"
    "uvicorn"
  ];

  propagatedBuildInputs = [
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
    exceptiongroup
    fsspec
    graphviz
    griffe
    httpcore
    httpx
    h2
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
  ];

  pythonImportsCheck = [ "prefect" ];

  meta = {
    description = "Prefect is a workflow orchestration framework for building resilient data pipelines in Python.";
    homepage = "https://www.prefect.io/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
