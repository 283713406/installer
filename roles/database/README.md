# 数据库部署
## postgres部署
1.配置变量
```bash
$ cd installer/

# 配置[all]中postgres1 postgres2 postgres3的ip地址
$ vim  inventory/inventory.ini

# 配置virtual_ip值，配置为同一网段未使用的IP
$ vim inventory/group_vars/postgres/postgresql.yml

# 配置install_database为true，uninstall_database为false
$ vim inventory/group_vars/all/global.yaml
```
2.执行安装
```bash
$ cd installer/
$ ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache
```
## mysql数据库部署
1.配置变量
```bash
$ cd installer/

# 配置[all]中mysql1 mysql2 mysql3的ip地址
$ vim  inventory/inventory.ini

# 配置install_database为true，uninstall_database为false
$ vim inventory/group_vars/all/global.yaml
```
2.执行安装
```bash
$ cd installer/
$ ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache
```
## keepalived部署(master节点)
```bash
$ cd installer/

# 配置[all]中master1 master2 master3的ip地址
$ vim  inventory/inventory.ini

# 配置virtual_ip值，配置为同一网段未使用的IP，注意IP地址不要与postgres部署中的virtual_ip重复
$ vim inventory/group_vars/k8s-master/keepalived.yml
```
2.执行安装
```bash
$ cd installer/
$ ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache
```

## 卸载
### 数据库与keepalived卸载
```bash
$ cd installer/

# 配置install_database为false，uninstall_database为true
$ vim inventory/group_vars/all/global.yaml

$ ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache
```