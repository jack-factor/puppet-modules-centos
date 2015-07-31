class phalcon {

    exec {
        'restart-nginx':
            command => "service nginx restart",
            require => Exec['echo-phalcon'],
    }

    exec{
        'echo-phalcon':
            command => 'echo "extension=phalcon.so" > /etc/php.d/phalcon.ini',
            require => Exec['Install-Phalcon'],
            unless => "ls /etc/php.d/phalcon.ini",
    }

    exec{
        'Install-Phalcon':
            command => "./install",
            cwd => "/home/vagrant/cphalcon/build",
            require => Exec['download'],
            unless => "ls /etc/php.d/phalcon.ini",
    }

    exec {
        'download':
            command => "git clone --depth=1 git://github.com/phalcon/cphalcon.git",
            unless => "ls /home/vagrant/cphalcon",
            require => Class['git']
    }

}
