terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }

    backend "s3"{
        # This is the backend configuration for the state file
        bucket = "terraform-url-shortener-state-config"
        key = "url-shortener/state"
    }
}

provider "aws" {}