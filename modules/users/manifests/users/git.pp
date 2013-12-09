class users::users::git{
  include 'users::util'

  user_acct {'git':
    fullname => "git",
    uid      => 1002,
    shell    => '/usr/bin/git-shell',
  }

}
