class nginx::defines::disable {}
  
define nginx::disable() {

  file { "/etc/nginx/sites-enabled/${name}":
    ensure => absent,
    notify => Class['nginx::services'],
  }

}
