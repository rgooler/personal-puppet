class git_server::install { 
  
  package { 'git':
    ensure => latest,
  }

}
