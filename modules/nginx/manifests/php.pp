class nginx::php {

  include 'nginx'
  include 'nginx::php::install'
  include 'nginx::php::configuration'

  Class['nginx'] -> Class['nginx::php::install'] 
  Class['nginx::php::install'] -> Class['nginx::php::configuration']

}
