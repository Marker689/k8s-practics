# Установка Kubernetes node (containerd runtime) с помощью kubeadm
[Инструкция по установке](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#join-nodes)

## Установка и подключение с первой попытки
### Установка минимального набора ПО
```shell script
{
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl containerd
    sudo apt-mark hold kubelet kubeadm kubectl

    sudo modprobe br_netfilter 
    sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sudo echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
    sudo echo "net.bridge.bridge-nf-call-arptables=1" >> /etc/sysctl.conf
    sudo echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf 
    sudo sysctl -p /etc/sysctl.conf
}
```

### Подключение рабочей ноды к кластеру 
```shell script
kubeadm join 192.168.103.11:6443 --token hwbgbw.32k0dapxd5bp5gbj \
        --discovery-token-ca-cert-hash sha256:293acadbd04d38feeddfd5a110d4fa3a14869b4a62348e480bc7f97748be8f2e 
```

Нода подключилась к кластеру. Некоторое время она находится в состоянии NotReady. 
В течение минуты она будет доступна для использования.