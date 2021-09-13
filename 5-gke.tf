# I comented out the service account resource block
# because I created one and only service account with full access
# to deploy every resources needed. Include a service account if 
# required in the resource block for service account

# resource "google_service_account" "default" {
#   account_id   = "service-account-id"
#   display_name = "Service Account"
# }


resource "google_container_cluster" "meazure-cluster" {
  name     = var.cluster_name
  location = var.region
  network    = google_compute_network.vpc_meazure.self_link
  subnetwork = google_compute_subnetwork.meazure-priv.name
  remove_default_node_pool = true
  initial_node_count       = 1


  release_channel {
    channel = "REGULAR"
  }

  network_policy {
    enabled = true
  }

}

resource "google_container_node_pool" "meazure-node-pool" {
  name       = var.node-pool_name
  location   = var.region
  project    = var.project_id
  cluster    = google_container_cluster.meazure-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.cluster_machine
    image_type   = var.cluster_image
    disk_size_gb = var.node_disk_size

  }

  autoscaling {
    min_node_count = var.min_node
    max_node_count = var.max_node
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

}

resource "null_resource" "openfaas-task" {
  depends_on = [
    google_container_node_pool.meazure-node-pool,
  ]

   triggers = {
    always_run = "${timestamp()}"
  }

    provisioner "local-exec" {
    command = <<EOF
    #!/bin/sh
    gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID
    kubectl create ns openfaas
    kubectl create ns openfaas-fn
    kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml
    helm repo add openfaas https://openfaas.github.io/faas-netes/
    helm repo update \
      && helm upgrade openfaas --install openfaas/openfaas --namespace openfaas --set functionNamespace=openfaas-fn --set generateBasicAuth=true --set serviceType=LoadBalancer
    PASSWORD=$(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode) && echo "OpenFaaS admin password: $PASSWORD" >> password.txt
    EOF
  }
}