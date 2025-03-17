{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pkgs,
  setuptools,
  click,
  packaging,
  pydantic,
  pystac,
  pystac-client,
  python-dotenv,
  pytz,
  requests,
  ...
}:
buildPythonPackage rec {
  pname = "planetary-computer";
  version = "1.0.0";
  format = "pyproject";
  docheck = false;

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-WVio4di6Gq/HrEWHjfLX0DQFgGrjHtLmdTM/rrypYMw=";
  };
  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    click
    packaging
    pydantic
    requests
    pystac
    pystac-client
    python-dotenv
    pytz
    requests
  ];
  pythonImportsCheck = [ "planetary_computer" ];

  meta = {
    description = "Python library for interacting with the Microsoft Planetary Computer.";
    homepage = "https://pypi.org/project/planetary-computer/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
