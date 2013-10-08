class imagemagick { 
  include 'imagemagick::install'
  include 'imagemagick::configuration'
  include 'imagemagick::services'
  include 'imagemagick::monitoring'

  Class['imagemagick::install'] -> Class['imagemagick::configuration'] -> Class['imagemagick::services']
}
