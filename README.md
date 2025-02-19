# Setup Minecraft Server on OCI

This project aims to set up a Minecraft server on Oracle Cloud Infrastructure (OCI) using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- Oracle Cloud API key pair for authentication against Oracle
- SSH key pair for accessing the instance
- OCI CLI installed and configured (optional)

## Project Structure

- `provider.tf`: Configures the OCI provider for Terraform.
- `instance.tf`: Defines the resources for the Minecraft server, including VCN, subnet, DHCP options, and the instance.
- `tf_apply_until_success.py`: A script that will run `terraform apply` repeatedly until it succeeds, due to the shortage of free tier machines on Oracle.

## Getting Started

1. **Clone the repository:**
    ```sh
    git clone <repository-url>
    cd setup-oci-minecraft
    ```

1. **Configure access with API keys:**
    See [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs) for more information.

1. **Add `terraform.tfvars` file:**
    Provide input values for the variables defined in variables.tf. Below is an example content:
    ```tf
    tenancy_ocid        = "ocid1.tenancy.oc1..aaaxxxxxxxxxxxxxxxxxxxxxx"
    user_ocid           = "ocid1.user.oc1..aaaxxxxxxxxxxxxxxxxxxxxxxxxx"
    key_fingerprint     = "3b:6f:1a:4d:9e:2c:7b:8a:5d:3f:6e:1b:9c:2d:7a:8e"
    private_key_path    = "<local-path-to-api-key>"
    region              = "eu-frankfurt-1"
    compartment_ocid    = "ocid1.tenancy.oc1..aaaxxxxxxxxxxxxxxxxxxxxxx"
    ssh_public_key_path = "<local-path-to-ssh-public-key>"
    instance_specs = {
        memory = 8
        cpus   = 3
    }
    ```

1. **Initialize and plan Terraform:**
    ```sh
    terraform init
    terraform plan
    ```

1. **Apply the Terraform configuration:**
    `terraform apply` will usually error out with `Error: 500-InternalError, Out of host capacity.` due to the depletion of free tier machines. Use [tf_apply_until_success.py](tf_apply_until_success.py) to execute apply until it succeeds.
    ```sh
    python tf_apply_until_success.py
    ```

## Cleanup

To destroy the resources created by Terraform, run:
```sh
terraform destroy