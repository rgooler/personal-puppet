class users::users::jinxy{
  include 'users::util'

  user_acct {'jinxy':
    fullname => "Jinxy Soliel",
    group    => 'users',
    uid      => 1001,
    pass     => $users::secret::jinxy,
  }

}
