class users::users::git{
  include 'users::util'

  user_acct {'git':
    fullname    => "git",
    uid         => 1002,
    recursehome => true,
  }

}
