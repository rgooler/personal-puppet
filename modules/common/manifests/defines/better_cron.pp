class common::defines::better_cron {}

define better_cron($cron_minute='*',$cron_hour='*',$cron_dom='*',$cron_month='*',$cron_dow='*',$cron_user='root',$path_var='',$path){
    file {"/etc/cron.d/${name}":
        ensure  => file,
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => template("common/etc/cron.d/generic_cron.erb"),
    }
}
