let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/a2e06fc3423c4be53181b15c28dfbe0bcf67dd73.tar.gz";
    sha256 = "0bjx4iq6nyhj47q5zkqsbfgng445xwprrslj1xrv56142jn8n5r9";
  }) {};

  pythonPackages = pkgs.python3Packages;
in
  pkgs.mkShell {
    buildInputs = [
      # cloud providers
      pkgs.awscli
      pkgs.aws-iam-authenticator
      pkgs.doctl
      pkgs.google-cloud-sdk

      # terraform
      pkgs.terraform

      # kubernetes
      pkgs.kubectl
      pkgs.kubernetes-helm

      # python
      pythonPackages.cookiecutter
      pythonPackages.pyyaml
      pythonPackages.pytest
      pythonPackages.black
      pythonPackages.flake8
      pythonPackages.sphinx
    ];

    shellHook = ''
       # digital ocean deployment
       export AWS_ACCESS_KEY_ID=$(gopass www/digitalocean.com/costrouchov@quansight.com qhub-terraform-state-spaces-access-key)
       export SPACES_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
       export AWS_SECRET_ACCESS_KEY=$(gopass www/digitalocean.com/costrouchov@quansight.com qhub-terraform-state-spaces-secret-key)
       export SPACES_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
       export DIGITALOCEAN_TOKEN=$(gopass www/digitalocean.com/costrouchov@quansight.com qhub-terraform)
       doctl kubernetes cluster kubeconfig save do-jupyterhub-dev

       # # amazon web services deployment
       # export AWS_ACCESS_KEY_ID=$(gopass www/aws.amazon.com/quansight-internal qhub-terraform-user-access-key)
       # export AWS_SECRET_ACCESS_KEY=$(gopass www/aws.amazon.com/quansight-internal qhub-terraform-user-secret-key)
    '';
  }
