class base{
  include users
}

node nas{
  include base,users::friends,samba
}
