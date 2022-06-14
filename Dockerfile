FROM harbor.kylincloud.org/proxy/docker/library/ubuntu:18.04

RUN mkdir -p /home/kubespray

WORKDIR /home/kubespray

COPY kylin/get-pip.py /usr/local/bin/
COPY kylin/ansible-kylin.patch  /usr/local/share/
COPY requirements.txt /usr/local/share/

RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update \
    && apt-get -y install sshpass openssh-client vim python3 curl jq \
                  ca-certificates curl gnupg2 rsync make gcc libffi-dev \
                  libssl-dev python3-dev net-tools iproute2 patch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN python3 /usr/local/bin/get-pip.py

RUN pip install -r /usr/local/share/requirements.txt

RUN patch -d /usr/local/lib/python3.6/dist-packages/ansible/module_utils/facts/system -p1 < /usr/local/share/ansible-kylin.patch

RUN sed -i 's/GSSAPIAuthentication yes//g' /etc/ssh/ssh_config
