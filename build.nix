{ pkgs ? import <nixpkgs> { }, pythonPackages ? pkgs.python3Packages }:

pythonPackages.buildPythonPackage {
  pname = "qhub-kubernetes";
  version = "master";

  src = ./.;

  propagatedBuildInputs = [
    pythonPackages.pyyaml
    pythonPackages.cookiecutter
  ];

  checkInputs = [
    pythonPackages.black
    pythonPackages.flake8
    pythonPackages.pytest
  ];

  checkPhase = ''
    black --check qhub

    flake8

    pytest
  '';
}
