{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,

  setuptools,
  setuptools-scm,
  writableTmpDirAsHomeHook,

  # dependencies
  aiofiles,
  aiohttp,
  cachetools,
  click,
  colorama,
  cryptography,
  fastapi,
  filelock,
  httpx,
  jinja2,
  jsonschema,
  networkx,
  packaging,
  pandas,
  pendulum,
  prettytable,
  psutil,
  psycopg2-binary,
  pydantic,
  python-dotenv,
  pyyaml,
  python-multipart,
  pulp,
  requests,
  rich,
  setproctitle,
  sqlalchemy,
  tabulate,
  typing-extensions,
  uvicorn,
  wheel,

  # optional
  ray,
  grpcio,
  protobuf,
  awscli,
  botocore,
  boto3,
  azure-cli,
  azure-core,
  azure-identity,
  azure-mgmt-network,
  azure-mgmt-compute,
  azure-storage-blob,
  msgraph-sdk,
  google-api-python-client,
  google-cloud-storage,
  pyopenssl,
  ibm-cloud-sdk-core,
#  ibm-vpc,
#  ibm-platform-services,
#  ibm-cos-sdk,
  docker,
  kubernetes,
  websockets,
  runpod,
  pyvmomi,
  ...
}:
buildPythonPackage rec {
  pname = "skypilot";
  version = "0.9.3";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "skypilot-org";
    repo = "skypilot";
    tag = "v${version}";
    hash = "sha256-iKNvzGiKM4QSG25CusZ1YRIou010uWyMLEAaFIww+FA=";
  };

  nativeBuildInputs = [
    writableTmpDirAsHomeHook
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies =
    [
      aiohttp
      aiofiles
      cachetools
      click
      colorama
      cryptography
      filelock
      fastapi
      httpx
      jinja2
      jsonschema
      networkx
      packaging
      pandas
      pendulum
      prettytable
      psutil
      psycopg2-binary
      pydantic
      python-dotenv
      pyyaml
      python-multipart
      pulp
      requests
      rich
      setproctitle
      sqlalchemy
      tabulate
      typing-extensions
      uvicorn
      wheel
    ]
    ++ aiohttp.optional-dependencies.speedups
    ++ fastapi.optional-dependencies.all
    ++ uvicorn.optional-dependencies.standard;

  optional-dependencies = {
    ray = [ ray ] ++ ray.optional-dependencies.default;
    remote = [
      grpcio
      protobuf
    ];
    aws = [
      awscli
      botocore
      boto3
      colorama
    ];
    azure = [
      azure-cli
      azure-core
      azure-identity
      azure-mgmt-network
      azure-mgmt-compute
      azure-storage-blob
      msgraph-sdk
    ];
    gcp = [
      google-api-python-client
      google-cloud-storage
      pyopenssl
    ];
    ibm = [
      ibm-cloud-sdk-core
#      ibm-vpc
#      ibm-platform-services
#      ibm-cos-sdk
    ];
    docker = [ docker ];
    lambda = [ ];
    cloudfare = [
      awscli
      botocore
      boto3
      colorama
    ];
    scp = [ ray ] ++ ray.optional-dependencies.default;
    kubernetes = [
      kubernetes
      websockets
    ];
    ssh = [
      kubernetes
      websockets
    ];
    runpod = [ runpod ];
    fluidstack = [ ];
    #    cudo = [cudo-compute];
    paperspace = [ ];
    #    do = [pydo azure-core azure-common];
    #    vast = [vastai-sdk];
    vsphere = [
      pyvmomi
      #     vsphere-automation-sdk
    ];
    #     nebius = [
    #     nebius
    #     ]
    #     ++ aws
    #     ;
  };

  pythonImportsCheck = [
    "sky"
  ];

  versionCheckProgramArg = "--version";

  meta = {
    description = "Run AI on Any Infra — Unified, Faster, Cheaper";
    homepage = "https://github.com/skypilot-org/skypilot";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "sky";
  };
}
