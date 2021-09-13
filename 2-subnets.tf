
resource "google_compute_subnetwork" "meazure-pub" {
  name          = var.pub_subnet_name
  ip_cidr_range = var.pub_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_meazure.name
}

resource "google_compute_subnetwork" "meazure-priv" {
  name          = var.priv_subnet_name
  ip_cidr_range = var.priv_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_meazure.name
}
