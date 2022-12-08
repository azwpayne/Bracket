k3s
===

## Add configuration

```bash
sudo yum install -y bash-completion
cat <<EOF>> /etc/bashrc
# about k8s configs
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias helm='helm --kubeconfig=/etc/rancher/k3s/k3s.yaml'
source <(helm completion bash)
EOF

source /etc/bashrc
```

## Ignore WARNING

```bash
# WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /etc/rancher/k3s/k3s.yaml
# WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /etc/rancher/k3s/k3s.yaml
chmod -R 600 /etc/rancher/k3s/
```