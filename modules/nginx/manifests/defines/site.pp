class nginx::defines::site {}

define nginx::site($root="${name}", $php=undef, $enable=true) {

  file { "/etc/nginx/sites-available/${name}":
    ensure  => file,
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    content => template('nginx/etc/nginx/sites-available/site.conf.erb'),
  }

  if $enable == true {
    nginx::enable { $name: }
  } else {
    nginx::disable { $name: }
  }

}
