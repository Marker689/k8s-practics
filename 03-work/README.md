### Longhorn
```bash
kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.4.x/deploy/longhorn.yaml
```
### Longhorn UI
```bash
kubectl expose deployment -n longhorn-system longhorn-ui --type LoadBalancer --port 80 --target-port 8000
```
---

### MetalLB
```bash
helm install metallb metallb/metallb -n metallb-system
```
#### metallb.yaml
```yaml
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - 172.16.16.40-172.16.16.50
  autoAssign: true
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default
```
---

### Nginx Ingress Example

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-nginx
spec:
  ingressClassName: nginx
  rules:
  - host: "pve.example.pro"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-nginx
            port:
             number: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  labels:
    run: my-nginx
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    run: my-nginx
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
spec:
  selector:
    matchLabels:
      run: my-nginx
  replicas: 2
  template:
    metadata:
      labels:
        run: my-nginx
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 80
```