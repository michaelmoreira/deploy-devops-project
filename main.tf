terraform {

  required_version = ">= 1.0.0"

  required_providers {
    #azurerm = #{
    #source  = "hashicorp/azurerm"
    #version = "2.94.0"
    #}

    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }

  #backend "azurerm" {
  #resource_group_name  = "remote-state"
  #storage_account_name = "michaelmoreiraremotestate"
  #container_name       = "remote-state"
  #key                  = "pipeline-github-actions/terraform.tfstate"
  #}
}

#provider "azurerm" {
#features {}
#}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "michaelmoreiraremotestate"
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      owner      = "michaelmoreira"
      managed-by = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "michaelmoreira-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}