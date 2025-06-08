# Argo Ecosystem
This project leverages the Argo Ecosystem to setup a DevOps platform ready for CI/CD, progressive rollouts, specialized workloads, events and notifications. It serves as a template for projects that want to modernize their ways of doing development and deployment without expending lots of money on tools.

## Requirements

- Kubernetes cluster up and running (for local development: [minikube](https://minikube.sigs.k8s.io/docs/start), [kind](https://kind.sigs.k8s.io/), etc.)
- kubectl
- helm

### Optional
- [Argo CLI](https://github.com/argoproj/argo-workflows/releases/)
- [Vault](https://developer.hashicorp.com/vault/install). A server in development mode is enough.

## Setup

A script is included to install all argo related tools in their common namespaces, to setup all these tools run:

```
./setup.sh
```

### Vault 

From the root of the repository start the vault server in dev mode by running

```sh
vault server -dev -dev-root-token-id root -config ./vault/config.hcl
```

Install the [vault plugin secrets github](https://github.com/martinbaillie/vault-plugin-secrets-github?tab=readme-ov-file#installation) using the `vault/plugins` folder, rename the plugin file to `vault-plugin-secrets-github` and make it executable:

```sh
# make executable
chmod +x ./vault/plugin/vault-plugin-secrets-github
```

Setup your GitHub app following the instructions in the [plugin repo](vault secrets enable -path=github vault-plugin-secrets-github). Retrieve the Application ID and save the private key to a file. These two must be set as they are required variables for this Terraform module, for that you can write a file called `secrets.auto.tfvars` in the `vault/terraform` folder with the following template:

```sh
github_app_id = "<your-app-id>"
github_prv_key_path = "<your-private-key-path>"

```

Now let's apply the configuration:

```sh
terraform -chdir=./vault/terraform apply 
```

> [!NOTE]
> This terraform module is only applying the steps documented in the vault-plugin-secrets-github README file to avoid running the specifc scripts each time the dev server is restarted.

To test that everything is working install your application to a repository or organization and get the Installation ID from the url, then run:

```sh
export VAULT_ADDR='http://127.0.0.1:8200'
vault login root
vault read /github/token installation_id=70166212
```
