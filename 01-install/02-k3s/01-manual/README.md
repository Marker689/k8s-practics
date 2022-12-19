### Install Master Node:
```bash
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_TOKEN=2b0ae540ceb7a90643cd07d176d6ca2e93cfdaf5 sh -s - server  --cluster-init --disable=traefik -disable=servicelb
```

### Install Second and Third Master Node:
```bash
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_TOKEN=2b0ae540ceb7a90643cd07d176d6ca2e93cfdaf5 sh -s - server  --server https://kube169:6443 --disable=traefik -disable=servicelb
```

### Install Workers:
```bash
curl -sfL https://get.k3s.io | K3S_URL=https://kube169:6443 K3S_TOKEN=2b0ae540ceb7a90643cd07d176d6ca2e93cfdaf5 sh -
```
---
