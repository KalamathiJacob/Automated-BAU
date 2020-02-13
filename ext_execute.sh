#!/bin/bash
input_file="/var/lib/jenkins/ansible/FlatFile_input"
echo -e "[all:vars]\nansible_user = mule_user\n[muleservers]" > /etc/ansible/hosts
cat $input_file | grep server_list | cut -d: -f2 | sed 's/\,/\n/g' >> /etc/ansible/hosts
todo=$(cat $input_file | grep action_to_perform | cut -d: -f2)
ansible-playbook /var/lib/jenkins/ansible/mulemaster.yml --extra-vars "todo=$todo"
