locals {
  instance_name = format("%s-%s", "${var.instance_name}", substr(md5("${module.gce-container.container.image}"), 0, 8))

  env_variables = [for name, value in "${var.env_variables}" : {
    name  = name
    value = value
  }]
}

resource "google_compute_network" "default" {
  name                    = "${var.network_name}"
  project                 = "${var.project_id}"
  auto_create_subnetworks = true
}

module "gce-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "3.1.1"

  container = {
    image   = "${var.image}"
    command = "${var.custom_command}"
    env     = "${local.env_variables}"
    securityContext = {
      privileged : "${var.privileged_mode}"
    }
    tty : "${var.activate_tty}"
  }

  restart_policy = "Always"
}

resource "google_compute_instance" "default" {
  for_each                  = toset(["1", "2", "3"])
  name                      = "${local.instance_name}-${each.key}"
  zone                      = "us-central1-a"
  project                   = "${var.project_id}"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${module.gce-container.source_image}"
    }
  }

  network_interface {
    network = "${var.network_name}"

    access_config {}
  }

  metadata = {
    gce-container-declaration = "${module.gce-container.metadata_value}"
  }

  labels = {
    container-vm = "${module.gce-container.vm_container_label}"
  }

  service_account {
    email = var.client_email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
