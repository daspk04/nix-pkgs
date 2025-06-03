{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  hatchling,
  hatch-fancy-pypi-readme,
  setuptools,
  setuptools-scm,

  # dependencies
  argcomplete,
  cachetools,
  cryptography,
  cursor,
  filelock,
  gitpython,
  gpuhunt,
  ignore-python,
  jsonschema,
  packaging,
  paramiko,
  psutil,
  pydantic,
  pydantic-duality,
  python-dateutil,
  pyyaml,
  python-multipart,
  requests,
  rich,
  rich-argparse,
  simple-term-menu,
  tqdm,
  typing-extensions,
  websocket-client,

  # optional
  aiocache,
  aiorwlock,
  alembic,
#  alembic-postgresql-enum,
  aiosqlite,
  apscheduler,
  asyncpg,
  azure-identity,
  azure-mgmt-authorization,
  azure-mgmt-compute,
  azure-mgmt-msi,
  azure-mgmt-network,
  azure-mgmt-resource,
  azure-mgmt-subscription,
  backports-entry-points-selectable,
  boto3,
  botocore,
  datacrunch,
  docker,
  fastapi,
  google-api-python-client,
  google-auth,
#  google-cloud-billing,
  google-cloud-compute,
  google-cloud-logging,
  google-cloud-storage,
#  google-cloud-tpu,
  grpcio,
  httpx,
  jinja2,
  kubernetes,
  nebius,
  oci,
  prometheus-client,
  pyopenssl,
  # python-dxf,
  python-json-logger,
  sentry-sdk,
  sqlalchemy,
  sqlalchemy-utils,
  starlette,
  uvicorn,
  watchfiles,
  ...
}:
buildPythonPackage rec {
  pname = "dstack";
  version = "0.19.11";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "dstackai";
    repo = "dstack";
    tag = version;
    hash = "sha256-fg4eWiFOYixrP34TdwnsfUSMIvmbQJeo4NYdiB86Zc4=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'gpuhunt==0.1.6' 'gpuhunt'
  '';

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
  ];

  dependencies = [
    argcomplete
    cachetools
    cryptography
    cursor
    filelock
    gitpython
    gpuhunt
    ignore-python
    jsonschema
    packaging
    paramiko
    psutil
    pydantic_1
    pydantic-duality
    python-dateutil
    pyyaml
    python-multipart
    requests
    rich
    rich-argparse
    simple-term-menu
    tqdm
    typing-extensions
    websocket-client
  ];

  optional-dependencies = lib.fix (self: {
    all =
      self.gateway
      ++ self.server
      ++ self.aws
      ++ self.azure
      ++ self.gcp
      ++ self.datacrunch
      ++ self.kubernetes
      ++ self.lambda
      ++ self.oci;

    aws = [
      boto3
      botocore
    ] ++ self.server;

    azure = [
      azure-identity
      azure-mgmt-authorization
      azure-mgmt-compute
      azure-mgmt-msi
      azure-mgmt-network
      azure-mgmt-resource
      azure-mgmt-subscription
    ] ++ self.server;

    datacrunch = [
      datacrunch
    ] ++ self.server;

    gateway = [
      aiocache
      aiorwlock
      fastapi
      httpx
      jinja2
      starlette
      uvicorn
    ];

    gcp = [
      google-api-python-client
      google-auth
#      google-cloud-billing
      google-cloud-compute
      google-cloud-logging
      google-cloud-storage
#      google-cloud-tpu
    ] ++ self.server;

    kubernetes = [
      kubernetes
    ] ++ self.server;

    lambda = [
      boto3
      botocore
    ] ++ self.server;

    nebius = [
      nebius
    ] ++ self.server;

    oci = [
      cryptography
      oci
      pyopenssl
    ] ++ self.server;

    server =
      [
        aiosqlite
        alembic
#        alembic-postgresql-enum
        apscheduler
        asyncpg
        backports-entry-points-selectable
        docker
        grpcio
        prometheus-client
        # python-dxf
        python-json-logger
        sentry-sdk
        sqlalchemy
        sqlalchemy-utils
        watchfiles
      ]
      ++ self.gateway
      ++ sqlalchemy.optional-dependencies.asyncio
      ++ sentry-sdk.optional-dependencies.fastapi;
  });

  pythonImportsCheck = [
    "dstack"
  ];

  versionCheckProgramArg = "--version";

  meta = {
    description = "open-source orchestration engine for running AI workloads on any cloud or on-premises";
    homepage = "https://github.com/dstackai/dstack";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "dstack";
  };
}
