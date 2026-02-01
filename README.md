# gcp-terraform ⚙️

**Purpose:** Terraform configuration to provision a Google Cloud Storage bucket and a GitHub Actions CI/CD workflow to plan and apply Terraform changes.

---

## Table of contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [CI/CD details](#cicd-details)
- [Security & Best Practices](#security--best-practices)
- [Troubleshooting](#troubleshooting)
- [Cleanup](#cleanup)
- [Contributing & License](#contributing--license)

---

## Project overview
- Terraform resource: `google_storage_bucket.my-bucket` (see `main.tf`).  
- GitHub Actions workflow: `.github/workflows/terraform.yml` (plans on PRs, applies on `main`).

---

## Prerequisites ✅
- Terraform CLI (>= 1.14.4 recommended)  
- Google Cloud project with billing enabled  
- GCP service account with necessary permissions (e.g., `roles/storage.admin`)  
- GitHub repository secret: `GCP_SA_KEY` (service account JSON key)

---

## Setup (GCP + GitHub secret) 💡
1. Create a service account and grant the required role:
   ```bash
   gcloud iam service-accounts create cicd-sa \
     --display-name="CI/CD SA"

   gcloud projects add-iam-policy-binding PROJECT_ID \
     --member="serviceAccount:cicd-sa@PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/storage.admin"

   gcloud iam service-accounts keys create key.json \
     --iam-account=cicd-sa@PROJECT_ID.iam.gserviceaccount.com
   ```

2. Add the service account key to your GitHub repository as a secret:
   - Go to your repository on GitHub.
   - Navigate to `Settings` > `Secrets and variables` > `Actions`.
   - Click `New repository secret`.
   - Name: `GCP_SA_KEY`
   - Value: (contents of `key.json`)

---

## Usage 🚀
- To test locally:
  ```bash
  terraform init
  terraform plan
  ```
- To apply changes:
  ```bash
  terraform apply
  ```

---

## CI/CD details GitHub Actions ⚙️
- Workflow file: `.github/workflows/terraform.yml`
- Triggers on:
  - `push` to `main` branch
  - Pull requests targeting `main`
- Jobs:
  - `plan`: Runs `terraform plan`
  - `apply`: Runs `terraform apply` (on push to `main`)

---

## Security & Best Practices 🔒
- Store sensitive data in GitHub Secrets, not in the code.
- Regularly rotate service account keys.
- Review IAM roles and permissions periodically.

---

## Troubleshooting 🛠️
- Common issues:
  - **Permission denied**: Check if the service account has the necessary permissions.
  - **Bucket already exists**: Ensure the bucket name is unique across Google Cloud.

---

## Cleanup 🧹
- To destroy all resources:
  ```bash
  terraform destroy
  ```

---

