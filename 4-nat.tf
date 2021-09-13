resource "google_compute_router_nat" "meazure-nat" {
  name                               = var.nat_name
  router                             = google_compute_router.meazure-router.name
  region                             = google_compute_router.meazure-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.priv_subnet_name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

    depends_on = [
    google_compute_subnetwork.meazure-priv,
  ]
}
