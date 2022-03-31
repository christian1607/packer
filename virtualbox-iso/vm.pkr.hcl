

source "virtualbox-iso" "centos" {
  vm_name          = "centos"
  boot_command   = [
    "<tab><bs>",
    "<bs><bs>",
    "<bs><bs>",
    "text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos8.cfg<enter><wait>"
  ]
  boot_wait      = "10s"
  disk_size      = 20000
  format         = "ovf"
  guest_os_type  = "RedHat_64"
  headless       = false
  http_directory = "http"
  iso_checksum   = "47ab14778c823acae2ee6d365d76a9aed3f95bb8d0add23a06536b58bb5293c0"
  iso_url          = "file:///Users/christian/Documents/devops/packer/isos/CentOS-8.2.2004-x86_64-minimal.iso"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "packer"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "packer"
  vboxmanage       = [
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"]
  ]
  
}


source "virtualbox-iso" "ubuntu" {
  vm_name          = "ubuntu"
  boot_command =  [
    "<esc><wait>",
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz",
    " auto=true",
    " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu.cfg",
    " locale=en_US<wait>",
    " console-setup/ask_detect=false<wait>",
    " console-setup/layoutcode=us<wait>",
    " console-setup/modelcode=pc105<wait>",
    " debconf/frontend=noninteractive<wait>",
    " debian-installer=en_US<wait>",
    " fb=false<wait>",
    " initrd=/install/initrd.gz<wait>",
    " kbd-chooser/method=us<wait>",
    " keyboard-configuration/layout=USA<wait>",
    " keyboard-configuration/variant=USA<wait>",
    " netcfg/get_domain=vm<wait>",
    " netcfg/get_hostname=packer<wait>",
    " grub-installer/bootdev=/dev/sda<wait>",
    " noapic<wait>",
    " -- <wait>",
    "<enter><wait>"  
  ]
  boot_wait      = "10s"
  disk_size      = 20000
  format         = "ovf"
  guest_os_type  = "Ubuntu_64"
  headless       = false
  http_directory = "http"
  iso_checksum   = "f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  iso_url          = "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso"
  ssh_username     = "packer"
  ssh_password     = "packer"
  ssh_port         = 22
  ssh_timeout      = "30m"
  shutdown_command = "echo 'packer'| sudo -S /sbin/halt -h -p"
  vboxmanage       = [
    ["modifyvm", "{{ .Name }}", "--memory", "1024"],
    ["modifyvm", "{{ .Name }}", "--cpus", "1"]
  ]
}

build {
  sources = [
    #"source.virtualbox-iso.ubuntu",
    "source.virtualbox-iso.centos"
  ]

  provisioner "shell" {
    only = ["virtualbox-iso.ubuntu"]
    execute_command = "echo 'packer'| {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["apt-get update -y"]
  }

  provisioner "shell" {
    only = ["virtualbox-iso.centos"]
    execute_command = "echo 'packer'| {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["yum update -y"]
  }
}
