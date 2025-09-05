# The GCP region where resources will be created.
region = "us-central1"

# --- Network Module Variables ---
# The name of the VPC network.
vpc_name = "my-vpc"

# The name of the private subnet.
private_subnet_name = "private-subnet"

# The name of the public subnet.
public_subnet_name = "public-subnet"

#A unique suffix for resources to prevent naming conflict
project_suffix = "v17"

# artifact repository name for the backend
artifact_repository_name = "backend"

#service account with permission for the k8s
service_account_id = "gke-node-sa"

#the name displayed for the service account
service_account_display_name = "GKE Node Service Account"

#k8s cluster name
cluster_name = "k8s"

#the storage disk used by the cluster name 
disk_name = "app-data-disk"