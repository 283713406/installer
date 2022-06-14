##NFS组件部署

本方案可使用客户提供的NFS服务或者使用麒麟容器云提供的NFS服务。

请根据项目实际情况进行选择。

### 1 使用麒麟云提供的NFS方案

首先确认NFS服务的IP：

> 假设集群规划部署NFS服务的节点所在IP为172.20.42.80
>
> 修改inventory/inventory.ini文件中all组下面nfs节点的ansible_host字段为172.20.42.80
>

修改inventory/group_vars/all/global.yaml文件中关于nfs的字段为如下：

> install_nfs: true  
>
> nfs_exist: false
>

部署执行命令：
```
$ ansible-playbook -i inventory/inventory.ini cluster.yml
```

### 2 使用客户提供的NFS服务

首先确认NFS服务的IP与服务目录：

> 假设客户提供的NFS服务的节点所在IP为172.20.42.80
>
> 假设客户提供NFS服务目录为/Kylinstorage

修改inventory/group_vars/all/global.yaml文件中关于nfs的字段为如下：

> install_nfs: true  
>
> nfs_exist: true
>  
> remote_nfs_server: 172.20.42.80
>
> remote_nfs_path: /Kylinstorage
>

部署执行命令：
```
$ ansible-playbook -i inventory/inventory.ini cluster.yml
```

##NFS组件卸载
### 1 麒麟云提供的NFS方案卸载

首先确认NFS服务的IP：

> 假设集群规划部署NFS服务的节点所在IP为172.20.42.80
>
> 修改inventory/inventory.ini文件中all组下面nfs节点的ansible_host字段为172.20.42.80
>

修改inventory/group_vars/all/global.yaml文件中关于nfs的字段为如下：

> install_nfs: false  
>
> uninstall_nfs: true 
>
> nfs_exist: false
>

卸载执行命令：
```
$ ansible-playbook -i inventory/inventory.ini cluster.yml
```

### 2 客户提供的NFS服务卸载

首先确认NFS服务的IP与服务目录：

> 假设客户提供的NFS服务的节点所在IP为172.20.42.80
>
> 假设客户提供NFS服务目录为/Kylinstorage

修改inventory/group_vars/all/global.yaml文件中关于nfs的字段为如下：

> install_nfs: false  
>
> uninstall_nfs: true 
>
> nfs_exist: true
>  
> remote_nfs_server: 172.20.42.80
>
> remote_nfs_path: /Kylinstorage
>

卸载执行命令：
```
$ ansible-playbook -i inventory/inventory.ini cluster.yml
```

## 跳过NFS组件的部署及卸载
修改inventory/group_vars/all/global.yaml文件中关于nfs的字段为如下：

> install_nfs: false  
>
> uninstall_nfs: false 