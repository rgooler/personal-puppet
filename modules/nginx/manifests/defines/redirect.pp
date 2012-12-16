class nginx::defines::redirect {}

define nginx::redirect($target) {

  file { "/etc/nginx/sites-available/${name}":
    ensure  => file,
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    content => template('nginx/etc/nginx/sites-available/redirect.conf.erb'),
  }

}
