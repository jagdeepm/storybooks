provider "mongodbatlas" {
  public_key = var.mongodbatlas_public_key
  private_key  = var.mongodbatlas_private_key
}

# cluster
resource "mongodbatlas_cluster" "mongo_cluster" {
  project_id   = var.atlas_project_id
  name         = "${var.app_name}-${terraform.workspace}"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"

  # Provider Settings "block"
  provider_name               = "GCP"
  disk_size_gb                = 10
  provider_instance_size_name = "M10"
}

# db user
resource "mongodbatlas_database_user" "mongo_user" {
  username           = "storybooks-user-${terraform.workspace}"
  password           = var.atlas_user_password
  project_id         = var.atlas_project_id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "storybooks"
  }
}

# ip whitelist
# resource "mongodbatlas_project_ip_access_list" "test" {
#   project_id = var.atlas_project_id
#   ip_address=google_compute_address.ip_address.address
#   comment    = ""
# }