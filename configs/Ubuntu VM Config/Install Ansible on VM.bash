sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
mkdir ~/ansible && cd ~/ansible

cd ~/ansible
nano inventory
    #Write This Code
[local]
192.168.254.135 ansible_ssh_user=ubuntu ansible_ssh_pass=ubuntu #use this code after enabling ssh (check /other_config/Enable SSH.bash)
localhost ansible_connection=local  #or use this code without enabling ssh

echo "Hello from Ansible!" > ~/Desktop/src.txt

nano copy_file.yml
    #Write This Code
- name: copy files to destination
  hosts: localhost
  connection: local
  tasks:
    - name: copy src.txt as dest.txt in the same dir
      copy:
        src: ~/Desktop/src.txt
        dest: ~/Desktop/dest.txt


ansible-playbook -i inventory copy_file.yml
ansible all -i inventory -m ping
ansible-playbook -i inventory configure_routers.yml
