# puppet-influxdb ![License][license-img]

1. [Overview](#overview)
2. [Description](#description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Miscellaneous](#miscellaneous)

## Overview

InfluxDB is  a time-series  database built  from the ground  up to  handle high
write &  query loads. InfluxDB is  a custom high performance  datastore written
specifically  for timestamped  data, including  DevOps monitoring,  application
metrics, IoT sensor data, & real-time analytics. Conserve space on your machine
by  configuring  InfluxDB   to  keep  data  for  a  defined   length  of  time,
automatically expiring &  deleting any unwanted data from  the system. InfluxDB
also offers a SQL-like query language for interacting with data.

[influxdata.com](https://www.influxdata.com/products/open-source/#influxdb)

## Description

Puppet module to install, deploy and configure influxdb.

## Setup

Copy this module in your modules folder without *puppet-* in the name.

or

```bash
puppet module install vpgrp-influxdb
```

## Usage

```puppet
class { 'influxdb':
  package => true,
  service => true,
}
```

## Limitations

So far, this is compatible with Debian, RedHat, and other derivatives.

## Development

Please read carefully CONTRIBUTING.md before making a merge request.

## Miscellaneous

```
    ╚⊙ ⊙╝
  ╚═(███)═╝
 ╚═(███)═╝
╚═(███)═╝
 ╚═(███)═╝
  ╚═(███)═╝
   ╚═(███)═╝
```

[license-img]: https://img.shields.io/badge/license-Apache-blue.svg
