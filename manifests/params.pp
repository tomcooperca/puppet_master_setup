class puppet_master_setup::params {
  $mem_total_bytes = 0 + $::facts['memory']['system']['total_bytes']
  $pm_master_java_xms = floor(($mem_total_bytes / 1024430) / 4)
  $pm_master_java_xmx = floor(($mem_total_bytes / 1024430) / 4)

  $master_java_xms = "${pm_master_java_xms}m"
  $master_java_xmx = "${pm_master_java_xmx}m"
}
