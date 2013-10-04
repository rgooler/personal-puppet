class django::install { 

  package {'django':
    ensure   => '1.5.4',
    provider => 'pip',
  }

}
