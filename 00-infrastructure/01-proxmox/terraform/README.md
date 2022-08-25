# Развертывание виртуальных машин Proxmox

Terraform разворачивает 4 виртуальные машины из образа ubuntu cloud 20.04 с использованием [плагина](../terraform-provider-proxmox)

## Подготовка

* [ ]  Отредактировать `pm_password` или задать переменную `PM_PASSWORD`
* [ ]  Отредактировать прочие параметры ВМ.

## Использование

Запуск:

```bash
terraform apply -auto-approve
```

Удаление машин:

```bash
terraform destroy -auto-approve
```
