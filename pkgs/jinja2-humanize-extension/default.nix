{
  lib,
  fetchFromGitHub,
  pyPkgs,
  pkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "jinja2-humanize-extension";
  version = "0.4.0";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/metwork-framework/jinja2_humanize_extension.git";
    ref = "refs/tags/v${version}";
    rev = "d3c9aeb92a48ee6f165e555d55aa47d257aead47";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
  ];

  propagatedBuildInputs = with pyPkgs; [
    humanize
    jinja2
  ];

  meta = {
    description = "a jinja2 extension to use humanize library inside jinja2 templates";
    homepage = "https://github.com/metwork-framework/jinja2_humanize_extension";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
