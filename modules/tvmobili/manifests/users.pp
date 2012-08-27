class tvmobili::users {

  include 'users::util'

  user_acct { 'tvmobili':
    fullname => 'TVMobili Daemon',
    uid      => 899,
  }

}
