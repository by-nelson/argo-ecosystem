# Setup GitHub Vault Plugin
# This should be the way to register the plugin, but it fails with a provider error:
# Root object was present, but now absent.
# resource "vault_plugin" "github" {
  # type    = "secret"
  # name    = "vault-plugin-secrets-github"
  # command = "vault-plugin-secrets-github"
  # sha256  = var.github_plugin_sha
# }

resource "null_resource" "github" {
  provisioner "local-exec" {
    command = "vault plugin register -sha256=$SHA256SUM -command=vault-plugin-secrets-github secret vault-plugin-secrets-github"
    environment = {
        VAULT_ADDR = var.vault_address
        VAULT_TOKEN = var.vault_token
        SHA256SUM = var.github_plugin_sha
    }
  }
}

resource "vault_mount" "github" {
  path        = "github"
  type        = "vault-plugin-secrets-github"
  description = "This is a secret plugin to generate GitHub tokens"

  depends_on = [
    resource.null_resource.github
  ]
}

resource "vault_generic_secret" "github_config" {
  path = "github/config"
 
  data_json = jsonencode({
    app_id = var.github_app_id
    prv_key = file("${var.github_prv_key_path}")
  })

  depends_on = [
    resource.vault_mount.github
  ]
}
