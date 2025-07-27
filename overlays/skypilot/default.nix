{
  lib,
  fetchPypi,
  buildPythonPackage,

  setuptools,
  setuptools-scm,
  writableTmpDirAsHomeHook,

  # dependencies
  aiofiles,
  aiohttp,
  cachetools,
  click,
  casbin,
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
  passlib,
  pendulum,
  prettytable,
  prometheus-client,
  psutil,
  psycopg2-binary,
  pydantic,
  pyjwt,
  python-dotenv,
  pyyaml,
  python-multipart,
  pulp,
  requests,
  rich,
  setproctitle,
  sqlalchemy,
  sqlalchemy-adapter,
  tabulate,
  typing-extensions,
  uvicorn,
  wheel,

  # optional
  awscli,
  azure-cli,
  azure-core,
  azure-identity,
  azure-mgmt-compute,
  azure-mgmt-network,
  azure-storage-blob,
  boto3,
  botocore,
  docker,
  google-api-python-client,
  google-cloud-storage,
  grpcio,
  ibm-cloud-sdk-core,
  #  ibm-cos-sdk
  #  ibm-platform-services
  #  ibm-vpc
  kubernetes,
  msgraph-sdk,
  nebius,
  protobuf,
  pyopenssl,
  pyvmomi,
  ray,
  runpod,
  websockets,
  ...
}:
buildPythonPackage rec {
  pname = "skypilot";
  version = "0.10.0";
  src = fetchPypi {
    inherit version pname;
    hash = "sha256-HOguSCe9YbmAqvZCiUHOeNIWH4DofmrxWoW8yDSCah8=";
  };

  # source doesn't have dashboard artifacts outputs needs to build them via npm
  #  src = fetchFromGitHub {
  #    owner = "skypilot-org";
  #    repo = "skypilot";
  #    tag = "v${version}";
  #    hash = "sha256-iKNvzGiKM4QSG25CusZ1YRIou010uWyMLEAaFIww+FA=";
  #  };

  nativeBuildInputs = [
    writableTmpDirAsHomeHook
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  # https://github.com/skypilot-org/skypilot/blob/master/sky/setup_files/dependencies.py
  dependencies =
    [
      aiohttp
      aiofiles
      cachetools
      casbin
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
      passlib
      pendulum
      prettytable
      prometheus-client
      psutil
      psycopg2-binary
      pydantic
      pyjwt
      python-dotenv
      pyyaml
      python-multipart
      pulp
      requests
      rich
      setproctitle
      sqlalchemy
      sqlalchemy-adapter
      tabulate
      typing-extensions
      uvicorn
      wheel
    ]
    ++ aiohttp.optional-dependencies.speedups
    ++ fastapi.optional-dependencies.all
    ++ uvicorn.optional-dependencies.standard;

  optional-dependencies = lib.fix (self: {

    aws = [
      awscli
      boto3
      botocore
      colorama
    ];

    azure = [
      azure-cli
      azure-core
      azure-identity
      azure-mgmt-compute
      azure-mgmt-network
      azure-storage-blob
      msgraph-sdk
    ] ++ self.ray;

    cloudfare = self.aws;

    #    cudo = [cudo-compute];

    #    do = [pydo azure-core azure-common];

    docker = [ docker ];

    fluidstack = [ ];

    gcp = [
      google-api-python-client
      google-cloud-storage
      pyopenssl
    ];

    ibm = [
      ibm-cloud-sdk-core
      #      ibm-cos-sdk
      #      ibm-platform-services
      #      ibm-vpc
    ] ++ self.ray;

    kubernetes = [
      kubernetes
      websockets
    ];

    lambda = [ ];

    nebius = [
      nebius
    ] ++ self.aws;

    paperspace = [ ];

    ray = [ ray ] ++ ray.optional-dependencies.default;

    remote = [
      grpcio
      protobuf
    ];

    runpod = [ runpod ];

    server = [
      casbin
      passlib
      pyjwt
      sqlalchemy-adapter
    ];

    scp = self.ray;

    ssh = self.kubernetes;

    #    vast = [vastai-sdk];

    vsphere = [
      pyvmomi
      #     vsphere-automation-sdk
    ];
  });

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
