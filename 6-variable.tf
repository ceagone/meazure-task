variable "region" {
  default = "us-central1"
  description = "- (Required) Region where resources will be created"
}

variable "google_credentials" {
  default = "meazure.json"
  description = "- (Required) Path/Name of GCP service account JSON credentials"
}

variable "project_id" {
  default = "proctor-u"
  description = "- (Required) Google project acct ID" 
}

variable "vpc_name" {
  default = "vpc-meazure"
  description = "- (Optional) GCP VPC name"  
}

variable "vpc_router" {
  default = "meazure-router"
  description = "- (Optional) GCP cloud router"  
}

variable "pub_subnet_cidr" {
  default = "10.0.0.0/16"
  description = "- (Optional) VPC public subnets cidr block"
}

variable "priv_subnet_cidr" {
  default = "10.1.0.0/16"
  description = "- (Optional) VPC private subnets cidr block"
}

variable "pub_subnet_name" {
  default = "meazure-pub-subnet"
  description = "- (Optional) Public subnet's name"
}

variable "priv_subnet_name" {
  default = "meazure-priv-subnet"
  description = "- (Optional) private subnet's name"
}

variable "nat_name" {
  default = "meazure-router-nat"
  description = "- (Optional) NAT router's name"
}

variable "cluster_name" {
  default = "meazure-cluster"
  description = "- (Required) Name of cluster"
}

variable "cluster_image" {
  default = "cos"
  description = "- (Required) Cluster's image type"
}

variable "node-pool_name" {
  default = "meazure-node-pool"
  description = "- (Optional) cluster's node-pool name"
}

variable "cluster_machine" {
  default = "e2-medium"
  description = "- (Required) Node-pool machine type"
}

variable "min_node" {
  default = "1"
  description = "- (Required) Maximum number of autoscaling node count" 
}

variable "max_node" {
  default = "5"
  description = "- (Required) Maximum number of autoscaling node count"
}

variable "node_disk_size" {
  default = "50"
  description = "- (Required) Disk size for each cluster node"
}