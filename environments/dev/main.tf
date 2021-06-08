# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


locals {
  env = "dev"
}

provider "google" {
  version = "~> 3.0"
}

module "instance_template" {
  source     = "../../modules/instance_template"
  region     = var.region
  project_id = var.project_id
  subnetwork = "default"
  service_account = {
    email  = "135833141613-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

module "compute_instance" {
  source            = "../../modules/compute_instance"
  region            = var.region
  zone              = var.zone
  subnetwork        = var.subnetwork
  num_instances     = var.num_instances
  hostname          = "instance-simple"
  instance_template = module.instance_template.self_link
  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}
