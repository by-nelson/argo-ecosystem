variable "vault_address" {
  type = string
  default = "http://127.0.0.1:8200"
}

variable "vault_token" {
  type = string
  default = "root"
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
