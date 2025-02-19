resource "oci_core_vcn" "minecraft_vcn" {
  cidr_block     = "10.0.0.0/16"
  display_name   = "minecraft_vcn"
  compartment_id = var.compartment_ocid
  dns_label      = "minecraft"
}

resource "oci_core_subnet" "minecraft_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.minecraft_vcn.id
  cidr_block     = "10.0.1.0/24"
  display_name   = "minecraft_subnet"
  dns_label      = "subnet1"
}

resource "oci_core_dhcp_options" "custom_dhcp_options" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.minecraft_vcn.id
  display_name   = "custom_dhcp_options"
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
  options {
    type                = "SearchDomain"
    search_domain_names = ["minecraft.oraclevcn.com"]
  }
}

resource "oci_core_instance" "minecraft_instance" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name # the first zone is depleted, maybe the third is not so busy
  shape               = "VM.Standard.A1.Flex"
  display_name        = "ampere_a1_instance_minecraft"

  create_vnic_details {
    subnet_id        = oci_core_subnet.minecraft_subnet.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  shape_config {
    ocpus         = var.instance_specs.cpus
    memory_in_gbs = var.instance_specs.memory
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "oracle_linux" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
}
