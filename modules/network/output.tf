output "private_subnet_ip_range_0" {
  value = google_compute_subnetwork.private_subnet.secondary_ip_range[0].range_name
}
output "private_subnet_ip_range_1" {
  value = google_compute_subnetwork.private_subnet.secondary_ip_range[1].range_name
}
output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}
output "private_subnet_id" {
  value = google_compute_subnetwork.private_subnet_id
}
