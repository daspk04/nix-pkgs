{
  lib,
  fetchFromGitHub,
  makeWrapper,
  buildPythonPackage,
  setuptools,
  hatchling,
  hatch-fancy-pypi-readme,
  # dependencies
  click,
  httpx,
  rich,
  playwright,
  playwright-driver,
  ...
}:
buildPythonPackage rec {
  pname = "notebooklm-py";
  version = "0.3.4";
  pyproject = true;
  docheck = false;

  src = fetchFromGitHub {
    owner = "teng-lin";
    repo = "notebooklm-py";
    tag = "v${version}";
    hash = "sha256-vrCgOYQngSmsv4rnl6CTNk26DB+BxgplwkVfznVbBZo=";
  };

  build-system = [
    setuptools
    hatchling
    hatch-fancy-pypi-readme
  ];

  nativeBuildInputs = [ makeWrapper ];

  dependencies = [
    click
    httpx
    rich
  ]
  ++ optional-dependencies.browser;

  optional-dependencies = lib.fix (_self: {
    browser = [
      playwright
      playwright-driver.browsers
    ];
  });

  pythonImportsCheck = [
    "notebooklm"
  ];

  meta = {
    description = "Unofficial Python library for automating Google NotebookLM";
    homepage = "https://github.com/teng-lin/notebooklm-py";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "notebooklm";
  };
}
