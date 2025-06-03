#   Copyright 2024 Pratyush Das
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
{
  cmake,
  clangStdenv,
  fetchFromGitHub,
  lib,
  buildPythonPackage,
  setuptools,

  # build inputs
  boost,
  blas,
  eigen,
  gtest,
  pybind11,

  # dependencies
  dask,
  numpy,
  xarray,

  pkgs,
  ...
}:
buildPythonPackage rec {
  pname = "pyinterp";
  version = "2025.3.0";
  format = "pyproject";
  docheck = false;

  src = fetchFromGitHub {
    owner = "CNES";
    repo = "pangeo-pyinterp";
    tag = version;
    hash = "sha256-y9I6poxka4EQ0DlIKDgLoYvPKrM9QFCQk1zmQqasgMk=";
  };

  # Remove the git submodule link to pybind11, patch setup.py build backend and version information
  postPatch = ''
    if [ -d third_party/pybind11 ]; then
      rm -rf third_party/pybind11
    fi
    mkdir -p third_party
    ln -sr ${pybind11.src} third_party/pybind11

    substituteInPlace pyproject.toml --replace-fail 'build-backend = "backend"' 'build-backend = "setuptools.build_meta"'
    substituteInPlace pyproject.toml --replace-fail 'backend-path = ["_custom_build"]' ""


    substituteInPlace setup.py \
      --replace-fail 'version=revision(),' 'version="${version}",'

    substituteInPlace src/pyinterp/__init__.py \
     --replace-fail 'from . import geodetic, geohash, version' 'from . import geodetic, geohash' \
     --replace-fail '__version__ = version.release()' '__version__ = "${version}"' \
     --replace-fail '__date__ = version.date()' '__date__ = "${version}"' \
     --replace-fail 'del version' ""
  '';

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    blas
    boost
    eigen
    gtest
    pybind11
  ];

  build-system = [
    setuptools
  ];

  setupPyBuildFlags = [
    "--cxx-compiler=${clangStdenv.cc}/bin/c++"
    "--c-compiler=${clangStdenv.cc}/bin/cc"
    "--build-unittests"
    "--cmake-args=-DGTEST_LIBRARY=${gtest}/lib/libgtest.a;-DGTEST_MAIN_LIBRARY=${gtest}/lib/libgtest_main.a;-DGTEST_INCLUDE_DIR=${gtest}/include;-Dpybind11_ROOT=${pybind11};-DPYBIND11_INSTALL=OFF;-DPYBIND11_TEST=OFF"
  ];

  dependencies = [
    dask
    numpy
    xarray
  ];

  pythonImportsCheck = [
    "pyinterp"
  ];

  meta = {
    description = "Python library for optimized geo-referenced interpolation";
    homepage = "https://github.com/CNES/pangeo-pyinterp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daspk04 ];
  };
}
