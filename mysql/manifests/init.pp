class mysql {
    class deploy {
        # ensure that all packages are installed.
        $packagelist = ["mysql", "mysql-server", "mysql-libs", "phpmyadmin"]
        package { $packagelist:
            ensure => "installed"
        }


	# ensure services are running.
        service { "mysqld":
        enable      => "true",
        ensure      => "running",
        hasrestart  => "true",
        hasstatus   => "true",
        require     => File["/etc/my.cnf"]
        }
    }

     define mysql_def ( $datadir, $user, $port, $max_connection, $logerr){	
	file { "/etc/my.cnf":
	    owner   => "root",
            group   => "root",
            mode    => 644,
            content => template("mysql/mysqld.erb"),
            notify  => Service["mysqld"]
             }
    }	
      
 


}
