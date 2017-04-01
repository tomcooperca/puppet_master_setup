class puppet_master_setup::node_groups (
  $master_java_xms          = $puppet_master_setup::params::master_java_xms,
  $master_java_xmx          = $puppet_master_setup::params::master_java_xmx,
) inherits puppet_master_setup::params {
  Node_group {
    ensure               => present,
    parent               => 'All Nodes',
    override_environment => true,
    require              => Package['puppetclassify'],
  }
  node_group { 'PE Master':
    classes              => {
      'pe_repo'                                          => {
        'base_path' => 'http://mywebserver.example.com/puppet',
      },
      # Enable pe_repo for all required operating systems
      'pe_repo::platform::el_6_x86_64'                   => {},
      'pe_repo::platform::el_7_x86_64'                   => {},
      'pe_repo::platform::windows_x86_64'                => {},
      'puppet_enterprise::profile::master'               => {
        'code_manager_auto_configure' => true,
        'file_sync_enabled'           => true,
        'r10k_private_key'            => '/etc/puppetlabs/puppetserver/ssh/id-control_repo',
        'r10k_remote'                 => 'git@github.com:myorg/control_repo.git',
        'java_args'                   => {
          'Xms' => $master_java_xms,
          'Xmx' => $master_java_xmx,
        },
      },
      'puppet_enterprise::profile::master::mcollective'  => {},
      'puppet_enterprise::profile::mcollective::peadmin' => {},
    },
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
  }
}
