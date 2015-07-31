Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

class update{
    exec{
        'yum-update':
            command => '/usr/bin/yum -y update',
            timeout => 1800,
    }
}

include update
include wget
include epel
include git
include nginx
include mysql
include php55
include phalcon
