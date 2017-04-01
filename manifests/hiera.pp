class puppet_master_setup::hiera {
  file { '/etc/puppetlabs/puppet/hiera.yaml' :
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet_master_setup/hiera.yaml',
    notify => Service['pe-puppetserver'],
  }
}
