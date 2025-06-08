variable "vault_address" {
  type = string
  default = "http://127.0.0.1:8200"
}

variable "vault_token" {
  type = string
  default = "root"
}

variable "k8s_address" {
  type = string
  default = "https://127.0.0.1:45535"
}

variable "k8s_ca_cert_base64" {
  type = string
}

variable "github_plugin_sha" {
  type = string
  default = "46056e4ce06961e4c87d30da0ed18422e69b680755f330cd2a78eac1749192b7"
}

variable "github_app_id" {
  type = string
}

variable "github_prv_key_path" {
  type = string
}
