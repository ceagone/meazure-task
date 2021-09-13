resource "google_compute_router" "meazure-router" {
  name    = var.vpc_router
  network = google_compute_network.vpc_meazure.name
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
  }
}