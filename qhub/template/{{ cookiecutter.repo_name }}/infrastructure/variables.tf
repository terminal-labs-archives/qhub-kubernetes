variable "name" {
  type    = string
  default = "{{ cookiecutter.project_name }}"
}

variable "environment" {
  type    = string
  default = "dev"
}

{% if cookiecutter.provider == "aws" %}
variable "region" {
  type    = string
  default = "{{ cookiecutter.amazon_web_services.region }}"
}

variable "availability_zones" {
  description = "AWS availability zones within AWS region"
  type        = list(string)
  default     = {{ cookiecutter.amazon_web_services.availability_zones }}
}

variable "vpc_cidr_block" {
  description = "VPC cidr block for infastructure"
  type        = string
  default     = "10.10.0.0/16"
}
{% elif cookiecutter.provider == "gcp" %}
variable "region" {
  type    = string
  default = "{{ cookiecutter.google_cloud_platform.region }}"
}

variable "availability_zones" {
  description = "GCP availability zones within region"
  type        = list(string)
  default     = {{ cookiecutter.google_cloud_platform.availability_zones }}
}
{% elif cookiecutter.provider == "do" %}
variable "region" {
  type    = string
  default = "{{ cookiecutter.digital_ocean.region }}"
}
{% endif -%}

# jupyterhub
variable "endpoint" {
  description = "Jupyterhub endpoint"
  type        = string
  default     = "{{ cookiecutter.endpoint }}"
}

variable "jupyterlab-image" {
  description = "Jupyterlab user image"
  type = object({
    name = string
    tag  = string
  })
  default = {
    name = "quansight/qhub-jupyterlab"
    tag  = "8a810739aeca2a359c33f95b81655710cfd2eff2"
  }
}

variable "dask-worker-image" {
  description = "Dask worker image"
  type = object({
    name = string
    tag  = string
  })
  default = {
    name = "quansight/qhub-dask-worker"
    tag  = "8a810739aeca2a359c33f95b81655710cfd2eff2"
  }
}
