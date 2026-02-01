resource "google_storage_bucket" "my-bucket" {
  name          = "cicdbuild-bucket-319"
  location      = "US"
  project = "spherical-depth-476520-e2"
  force_destroy = true
  public_access_prevention = "enforced"
}