variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user"
  type        = string
}

variable "key_fingerprint" {
  description = "The fingerprint of the API signing key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key file"
  type        = string
}

variable "region" {
  description = "The OCI region"
  type        = string
}

variable "compartment_ocid" {
  description = "The OCID of the compartment"
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "instance_specs" {
  description = "The specs of the instance"
  type = object({
    memory = number
    cpus   = number
  })
}
