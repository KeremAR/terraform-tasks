variable "ssh_key" {
  type        = string
  description = "Provides custom public SSH key."
  # No default value, so Terraform requires it from the environment.
} 