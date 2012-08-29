class common::defines::dpkg_install{}

define dpkg_install(){
    exec{ "dpkg -i ${name}": }
}
