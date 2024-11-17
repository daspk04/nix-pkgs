{
  lib,
  fetchFromGitHub,
  pyPkgs,
  ...
}:
pyPkgs.buildPythonPackage rec {
  pname = "verde";
  version = "1.8.1";
  format = "pyproject";
  docheck = false;

  src = builtins.fetchGit {
    name = pname;
    url = "https://github.com/fatiando/verde.git";
    ref = "refs/tags/v${version}";
    rev = "8d1c58ea4f62290fc8db849748b0706e189ea7be";
  };

  nativeBuildInputs = with pyPkgs; [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = with pyPkgs; [
    numpy
    scipy
    pandas
    xarray
    scikit-learn
    pooch
    dask
    pykdtree
    numba
  ];

  pythonImportsCheck = [
    "verde"
  ];
  meta = {
    description = "Verde is a Python library for processing spatial data (topography,
    point clouds, bathymetry, geophysics surveys, etc) and interpolating
    them on a 2D surface (i.e., gridding) with a hint of machine learning.
    Our core interpolation methods are inspired by machine-learning. As
    such, Verde implements an interface that is similar to the popular
    scikit-learn library. We also provide other analysis methods that are
    often used in combination with gridding, like trend removal,
    blocked/windowed operations, cross-validation, and more!";
    homepage = "https://www.fatiando.org/verde/latest/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [daspk04];
  };
}
