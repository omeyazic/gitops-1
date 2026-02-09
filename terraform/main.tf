terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "~> 1.4.2"
    }
  }
}

provider "multipass" {}

# Control Plane Node
resource "multipass_instance" "k3s_control" {
  name   = "gitops-control-plane"
  cpus   = 2
  memory = "3G"
  disk   = "10G"
  image  = "22.04"

  cloudinit_file = "${path.module}/cloud-init-control.yaml"
}

# Worker Node
resource "multipass_instance" "k3s_worker" {
  name   = "gitops-worker-node"
  cpus   = 2
  memory = "3G"
  disk   = "10G"
  image  = "22.04"

  cloudinit_file = "${path.module}/cloud-init-worker.yaml"

  depends_on = [multipass_instance.k3s_control]
}
