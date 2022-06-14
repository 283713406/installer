# 初始化MySQL数据

修改 `inventory/group_vars/dbinit/dbinit.yaml` 配置

|配置项|数据类型|说明|
|---|---|---|
|is_external    |string|MySQL是否在k8s之外|
|mysql_uri      |string|外部MySQL地址|
|mysql_port     |string|外部MySQL端口|
|mysql_user     |string|外部MySQL用户|
|mysql_pwd      |string|外部MySQL密码|
|tianyu         |string|是否初始化天域相关数据|
|mirrors_update |string|是否初始化镜像仓库相关数据|
|softshop       |string|是否初始化软件商店相关数据|

执行命令：
```
$ ansible-playbook -i inventory/inventory.ini dbinit-playbook.yml
```