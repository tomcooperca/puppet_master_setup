# puppet_master_setup

#### Table of Contents

1. [Description](#description)
1. [Usage](#usage)

## Description

This module is used to manage a Puppet Enterprise monolithic master (running PE Console).
It uses the `puppetclassify` gem and pro_svcs/node_manager module for manipulating
node groups. You can use this to Puppetize your org's node groups instead of managing
them via the PE Console.

Also includes a handy class for generating MCollective inventory reports, running
them via cron and scp the result to a web server.

## Usage

```
# Compile Masters
include puppet_master_setup::hiera

# Monolithic master(s)
include puppet_master_setup::hiera
include puppet_master_setup::install
include puppet_master_setup::node_groups
include puppet_master_setup::mco_reports
```
