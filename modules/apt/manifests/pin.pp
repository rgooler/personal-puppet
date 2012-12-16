# pin.pp
# pin a release in apt, useful for unstable repositories

define apt::pin(
  $packages = '*',
  $pinline = undef,
  $priority = 0
) {

  include apt::params

  if $pinline == undef {
    $pl = "release a=${name}"
  } else {
    $pl = $pinline
  }

  file { "${name}.pref":
    ensure  => file,
    path    => "${apt::params::root}/preferences.d/${name}",
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "# ${name}\nPackage: ${packages}\nPin: ${pl}\nPin-Priority: ${priority}",
  }
}
