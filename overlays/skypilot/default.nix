{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  buildNpmPackage,

  python,

  setuptools,
  setuptools-scm,
  writableTmpDirAsHomeHook,

  # dependencies
  aiofiles,
  aiohttp,
  aiosqlite,
  alembic,
  asyncpg,
  bcrypt,
  cachetools,
  click,
  colorama,
  cryptography,
  fastapi,
  filelock,
  gitpython,
  httpx,
  ijson,
  jinja2,
  jsonschema,
  networkx,
  packaging,
  pandas,
  paramiko,
  passlib,
  pendulum,
  pip,
  prettytable,
  prometheus-client,
  psutil,
  psycopg2-binary,
  pycasbin,
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
  types-paramiko,
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
let
  pname = "skypilot";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "skypilot-org";
    repo = "skypilot";
    tag = "v${version}";
    hash = "sha256-zxkduComvFuSbWnWSw1PYalGdVhiwCIjElXEg7VPw88=";
  };

  dashboard = buildNpmPackage {
    inherit pname version src;

    sourceRoot = "${src.name}/sky/dashboard";
    npmDepsHash = "sha256-8uZzkDJkaDPFXXsGy29jkaw6g8bPe3drbboYHHa6YuU=";

    installPhase = ''
      mkdir -p $out
      cp -r out/* $out/
    '';
  };
in
buildPythonPackage rec {
  inherit pname version src;
  pyproject = true;

  nativeBuildInputs = [
    writableTmpDirAsHomeHook
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  env.SETUPTOOLS_SCM_PRETEND_VERSION = version;

  postPatch = ''
    sed -i 's/casbin/pycasbin/g' sky/setup_files/dependencies.py
  '';

  # https://github.com/skypilot-org/skypilot/blob/master/sky/setup_files/dependencies.py
  dependencies = [
    aiohttp
    aiofiles
    aiosqlite
    alembic
    asyncpg
    bcrypt
    cachetools
    click
    colorama
    cryptography
    filelock
    fastapi
    gitpython
    httpx
    ijson
    jinja2
    jsonschema
    networkx
    packaging
    pandas
    paramiko
    passlib
    pendulum
    pip
    prettytable
    prometheus-client
    psutil
    psycopg2-binary
    pycasbin
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
    types-paramiko
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
    ]
    ++ self.ray;

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
    ]
    ++ self.ray;

    kubernetes = [
      kubernetes
      websockets
    ];

    lambda = [ ];

    nebius = [
      nebius
    ]
    ++ self.aws;

    paperspace = [ ];

    ray = [ ray ] ++ ray.optional-dependencies.default;

    remote = [
      grpcio
      protobuf
    ];

    runpod = [ runpod ];

    server = [
      pycasbin
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

  pythonRelaxDeps = true;

  postInstall = ''
    mkdir -p $out/${python.sitePackages}/sky/dashboard/out
    cp -r ${dashboard}/* $out/${python.sitePackages}/sky/dashboard/out/
  '';

  versionCheckProgramArg = "--version";

  meta = {
    description = "Run AI on Any Infra — Unified, Faster, Cheaper";
    homepage = "https://github.com/skypilot-org/skypilot";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "sky";
  };
}
