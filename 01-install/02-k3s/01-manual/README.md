Install Master Node:

```bash
curl -sfL https://get.k3s.io | sh -
```

Export Token For Worker Node:

```bash
cat /var/lib/rancher/k3s/server/node-token
```

Install Worker Node:

```bash
export MASTER_NODE=192.168.103.11
export K3S_TOKEN=INSERT_YOUR_TOKEN_HERE
MASTER_NODE=192.168.103.11 curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_NODE:6443 K3S_TOKEN=$K3S_TOKEN sh -
```
