class tvmobili::users {

  include 'users::util'

  user_acct { 'tvmobili':
    fullname => 'TVMobili Daemon',
    group    => 'tvmobili',
    uid      => 899,
  }

}
