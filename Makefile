install-all:
	# 以后需要部署apps时可将注释的行替换后面三行
	# sed -i '/^install/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_bootstrap/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/false/true/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^uninstall/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

uninstall-all:
	# sed -i '/^install/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^uninstall/s/false/true/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache
	
install-bootstrap:
	sed -i '/^install_bootstrap/s/false/true/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^uninstall/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

install-database:
	sed -i '/^install_database/s/false/true/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^uninstall/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

install-nfs:
	sed -i '/^install_nfs/s/false/true/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^uninstall/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

uninstall-bootstrap:
	sed -i '/^uninstall_bootstrap/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^uninstall_database/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

uninstall-database:
	sed -i '/^uninstall_database/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^uninstall_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

uninstall-nfs:
	sed -i '/^uninstall_nfs/s/false/true/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_nfs/s/true/false/g' inventory/group_vars/all/global.yaml
	
	sed -i '/^uninstall_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_bootstrap/s/true/false/g' inventory/group_vars/all/global.yaml
	sed -i '/^install_database/s/true/false/g' inventory/group_vars/all/global.yaml
	ansible-playbook -i inventory/inventory.ini cluster.yml -b -v --flush-cache

install-keepalived:
	ansible-playbook -i inventory/inventory.ini -e "install_keepalived=true" --tags "keepalived-alone" cluster.yml -b -v --flush-cache

uninstall-keepalived:
	ansible-playbook -i inventory/inventory.ini -e "reset_keepalived=true" --tags "keepalived-alone" cluster.yml -b -v --flush-cache

install-dbinit:
	ansible-playbook -i inventory/inventory.ini dbinit-playbook.yml
