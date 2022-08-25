# Установка Kubernetes (containerd runtime) с помощью kubeadm
[Инструкция по установке](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

## Отключение SWAP
```shell script
  swapoff -a
  # kubelet requires swap off
````


## Установка с первой попытки
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
### Инициализация кластера
```shell script
ip a

# Указываем адрес в параметрах, добавляем внешний адрес
# Инициализация кластера
kubeadm init \
  --apiserver-advertise-address=192.168.103.11 \
  --pod-network-cidr 10.244.0.0/16
```
### Копирование доступов и загрузка плагина CNI flannel 
```shell script
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

Control plane нода установлена.


## Если что-то пошло не так
```shell script
# Сброс кластера
kubeadm reset

# Проблемы с cgroup
cat > /etc/containerd/config.toml <<EOF
[plugins."io.containerd.grpc.v1.cri"]
  systemd_cgroup = true
EOF
systemctl restart containerd

# Просмотр запущенных контейнеров
crictl ps -a
crictl logs POD_ID
```

Документация по [crictl](https://kubernetes.io/docs/tasks/debug-application-cluster/crictl/)


