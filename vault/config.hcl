plugin_directory="./vault/plugins"

listener "tcp" {
    address = "0.0.0.0:8222"
    tls_disable = true
}
