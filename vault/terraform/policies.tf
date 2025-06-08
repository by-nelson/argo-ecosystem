resource "vault_policy" "create_github_token" {
  name = "create-github-token"

  policy = <<EOF
path "github/token" {
  capabilities = ["update", "read", "create"]
}
EOF

  depends_on = [ 
    vault_auth_backend.kubernetes 
  ]
}

resource "vault_kubernetes_auth_backend_role" "github_token_refresher" {
  backend = vault_auth_backend.kubernetes.path
  role_name = "github_token_refresher"
  bound_service_account_names = ["vault-updater-sa"]
  bound_service_account_namespaces = ["argo"]
  token_ttl = 3600 # 1 hour
  token_max_ttl = 14400 # 4 hours
  token_policies = [
    vault_policy.create_github_token.name
  ]
}
