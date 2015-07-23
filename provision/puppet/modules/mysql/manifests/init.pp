class mysql
{
    package { 'mysql-community-server':
        provider => 'rpm',
        ensure => installed,
        source => '-Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm',
        require => Class['Update'],
    }
    
    service { 'mysqld':
        enable => true,
        ensure => running,
        require => Package['mysql-community-server'],
    }
    

}
