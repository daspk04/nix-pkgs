{
  lib,
  fetchFromGitHub,
  buildPythonPackage,

  hatchling,

  aiosqlite,
  alembic,
  anyio,
  apprise,
  asgi-lifespan,
  asyncpg,
  cachetools,
  click,
  cloudpickle,
  coolname,
  croniter,
  cryptography,
  dateparser,
  docker,
  exceptiongroup,
  fastapi,
  fsspec,
  graphviz,
  griffe,
  httpcore,
  httpx,
  humanize,
  importlib-metadata,
  jsonpatch,
  jsonschema,
  jinja2,
  jinja2-humanize-extension,
  orjson,
  opentelemetry-api,
  packaging,
  pathspec,
  pendulum,
  prometheus-client,
  pydantic,
  pydantic-core,
  pydantic-extra-types,
  pydantic-settings,
  python-dateutil,
  python-slugify,
  python-socks,
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
  tzdata,
  ujson,
  uv,
  uvicorn,
  websockets,
  ...
}:
buildPythonPackage rec {
  pname = "prefect";
  version = "3.4.4";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "PrefectHQ";
    repo = "prefect";
    rev = version;
    sha256 = "sha256-DsqnYfX0mO2WNTY009zJQuU4Q6GWSzxrPenAVce7jIY=";
  };

  build-system = [
    hatchling
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'requires = ["hatchling", "versioningit"]' 'requires = ["hatchling"]'
    substituteInPlace pyproject.toml --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
    substituteInPlace src/prefect/__init__.py \
      --replace-fail 'from . import _build_info' "" \
      --replace-fail 'del _build_info, pathlib' "del pathlib" \
      --replace-fail '__version__ = _build_info.__version__' '__version__ = "${version}"' \
      --replace-fail '__version_info__: "VersionInfo" = cast(
        "VersionInfo",
        {
            "version": __version__,
            "date": _build_info.__build_date__,
            "full-revisionid": _build_info.__git_commit__,
            "error": None,
            "dirty": _build_info.__dirty__,
        },
    )' '__version_info__ = {
        "version": "${version}",
        "date": "1970-01-01T00:00:00+00:00",
        "full-revisionid": "${src.rev}",
        "error": None,
        "dirty": False,
    }'
  '';

  # https://github.com/conda-forge/prefect-feedstock/blob/main/recipe/meta.yaml
  dependencies =
    [
      aiosqlite
      alembic
      anyio
      apprise
      asgi-lifespan
      asyncpg
      cachetools
      click
      cloudpickle
      coolname
      croniter
      cryptography
      dateparser
      docker
      exceptiongroup
      fastapi
      fsspec
      graphviz
      griffe
      httpcore
      httpx
      humanize
      importlib-metadata
      jinja2
      jinja2-humanize-extension
      jsonpatch
      jsonschema
      opentelemetry-api
      orjson
      packaging
      pathspec
      pendulum
      prometheus-client
      pydantic
      pydantic-core
      pydantic-extra-types
      pydantic-settings
      python-slugify
      python-dateutil
      python-socks
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
      tzdata
      ujson
      uv
      uvicorn
      websockets
    ]
    ++ httpx.optional-dependencies.http2
    ++ python-socks.optional-dependencies.asyncio
    ++ sqlalchemy.optional-dependencies.asyncio;

  versionCheckProgramArg = "--version";

  pythonImportsCheck = [ "prefect" ];

  meta = {
    description = "Prefect is a workflow orchestration framework for building resilient data pipelines in Python.";
    homepage = "https://www.prefect.io/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "prefect";
  };
}
