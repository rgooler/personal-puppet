class git_server { 
  include 'users::users::git'
  include 'git_server::install'
  include 'git_server::configuration'
  include 'git_server::services'
  include 'git_server::monitoring'

  Class['users::users::git'] -> Class['git_server::install']
  Class['git_server::install'] -> Class['git_server::configuration'] -> Class['git_server::services']
}
