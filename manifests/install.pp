class puppet_master_setup::install {
  package { 'puppetclassify' :
    ensure   => '0.1.3',
    provider => 'puppet_gem',
  }
}
