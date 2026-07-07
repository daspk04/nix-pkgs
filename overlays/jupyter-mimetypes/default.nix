{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  hatchling,
  pyarrow,
  typing-extensions,
  ...
}:
buildPythonPackage rec {
  pname = "jupyter-mimetypes";
  version = "0.2.0";
  pyproject = true;
  doCheck = false;

  src = fetchFromGitHub {
    owner = "datalayer";
    repo = "jupyter-mimetypes";
    rev = "53d886c2e585cf0695cd39bae364168a10684bcf";
    hash = "sha256-1jOETqY2JYKc3CHXlGFYaPt4Pcx2osiqtnTIAE8MTh8=";
  };

  build-system = [ hatchling ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
  '';

  dependencies = [
    pyarrow
    typing-extensions
  ];

  pythonImportsCheck = [ "jupyter_mimetypes" ];

  meta = {
    description = "Jupyter MIME types utilities";
    homepage = "https://github.com/datalayer/jupyter-mimetypes";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}