class base{
  include vim
}

node nas{
  include base,samba
  include rtorrent
}
