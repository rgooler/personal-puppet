class nginx::defines::enable {}
  
define nginx::enable() {

  file { "/etc/nginx/sites-enabled/${name}":
    ensure => link,
    target => "/etc/nginx/sites-available/${name}",
    notify => Class['nginx::services'],
  }

}
