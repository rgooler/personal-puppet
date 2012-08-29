class common::defines::dpkg_install{}

define dpkg_install(){
    exec{ "/usr/bin/dpkg -i ${name}": }
}
