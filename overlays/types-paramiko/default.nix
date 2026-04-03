{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
  cryptography,
  ...
}:
buildPythonPackage rec {
  pname = "types-paramiko";
  version = "4.0.0.20250822";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "types_paramiko";
    hash = "sha256-G1awy9Puw9L9EjyesnBOYSt3fhWhdwWoBCeeplJeDFM=";
  };

  build-system = [
    setuptools
  ];

  postPatch = ''
    sed -i 's/paramiko-stubs/paramiko_stubs/g' pyproject.toml
    mv paramiko-stubs paramiko_stubs
  '';

  dependencies = [
    cryptography
  ];

  meta = {
    description = "Typing stubs for paramiko";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
