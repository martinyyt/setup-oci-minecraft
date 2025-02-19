# Setup OCI Minecraft

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

1. **Clone the repository**:
    ```sh
    git clone <repository-url>
    cd setup-oci-minecraft
1. **Configure access with api keys:** see [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)
1. **Add `terraform.tfvars` file:** Provide input values for the variables defined in [variables.tf](variables.tf).
1. **Initialize and plan Terraform:**
    ```sh
    terraform init
    terraform plan
    ```
1. **Apply the Terraform configuration:** `terraform apply` will usually error out with `Error: 500-InternalError, Out of host capacity.` due to the depletion of free tier machines. Use [tf_apply_until_success.py](tf_apply_until_success.py) to execute apply until it succeeds.
    ```sh
    python tf_apply_until_success.py
    ```

## Cleanup

To destroy the resources created by terraform, run:
```sh
terraform destroy
```
 