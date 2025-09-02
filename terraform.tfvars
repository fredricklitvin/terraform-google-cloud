# The name of your GCP project.
#project_id = "your-gcp-project-id"

# The GCP region where resources will be created.
region = "us-central1"

# --- Network Module Variables ---
# The name of the VPC network.
vpc_name = "my-vpc"

# The name of the private subnet.
private_subnet_name = "private-subnet"

# The CIDR range for the private subnet.
private_subnet_cidr_range = "10.1.0.0/16"

# The CIDR range for GKE pods in the private subnet.
private_subnet_cidr_range_pods = "10.3.0.0/16"

# The CIDR range for GKE services in the private subnet.
private_subnet_cidr_range_services = "10.4.0.0/16"

# The name of the public subnet.
public_subnet_name = "public-subnet"

# The CIDR range for the public subnet.
public_subnet_cidr_range = "10.2.0.0/16"

# The name of the cloud router.
router_name = "vpc-router"

# The name of the Cloud NAT gateway.
nat_name = "nat"
