// This could be encapsulated as a data source
data "terraform_remote_state" "topology" {
  backend = "local"

  config {
    path = "${path.cwd}/topology.tfstate"
  }
}

data "terraform_remote_state" "assets" {
  backend = "local"

  config {
    path = "${path.cwd}/assets.tfstate"
  }
}

locals {
  ignition           = "${data.terraform_remote_state.assets.ignition_etcd}"
  sg_id              = "${data.terraform_remote_state.topology.etcd_sg_id}"
  subnet_ids_workers = "${data.terraform_remote_state.topology.subnet_ids_workers}"
  s3_bucket          = "${data.terraform_remote_state.topology.s3_bucket}"
  private_zone_id    = "${data.terraform_remote_state.topology.private_zone_id}"
}
