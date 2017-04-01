# Periodic MCO inventory reports to run on the master
# Reports (.mc) must be either local, in a module or via http
class puppet_master_setup::mco_reports (
  Hash $urls,
  Variant[Integer,Array] $cron_hour     = 20,
  Variant[Integer,Array] $cron_weekday  = 1,
  Variant[Integer,Array] $cron_monthday = 1,
) {

  $urls.each |String $filename, Hash $url_params| {
    file { "/var/lib/peadmin/${filename}" :
      ensure => file,
      owner  => 'peadmin',
      group  => 'peadmin',
      source => $url_params['source'],
    }
    file { "/var/lib/peadmin/cron_${filename}.sh" :
      ensure  => file,
      owner   => 'peadmin',
      group   => 'peadmin',
      mode    => '0755',
      content => epp('puppet_master_setup/mco_report_bash.epp',{
        'filename'   => $filename,
        'factfilter' => $url_params['filter'],
      }),
    }
    $cron_command = "/bin/bash /var/lib/peadmin/cron_${filename}.sh"
    case $url_params['schedule'] {
      'daily': {
        cron { "mco_${filename}" :
          command  => $cron_command,
          user     => 'peadmin',
          hour     => $cron_hour,
          minute   => 0,
          weekday  => '*',
          monthday => '*',
          month    => '*',
        }
      }
      'weekly': {
        cron { "mco_${filename}" :
          command  => $cron_command,
          user     => 'peadmin',
          hour     => $cron_hour,
          minute   => 0,
          weekday  => $cron_weekday,
          monthday => '*',
          month    => '*',
        }
      }
      'monthly': {
        cron { "mco_${filename}" :
          command  => $cron_command,
          user     => 'peadmin',
          hour     => $cron_hour,
          minute   => 0,
          weekday  => $cron_weekday,
          monthday => $cron_monthday,
          month    => '*',
        }
      }
      'quarterly': {
        cron { "mco_${filename}" :
          command  => $cron_command,
          user     => 'peadmin',
          hour     => 0,
          minute   => 0,
          weekday  => 1,
          monthday => $cron_monthday,
          month    => [ 3, 6, 9, 12],
        }
      }
      default: {
        fail("puppet_master_setup::mco_reports - 'schedule' key must be used for each report.
          Use 'schedule' => [daily|weekly|monthly|quarterly]")
      }
    }
  }
}
