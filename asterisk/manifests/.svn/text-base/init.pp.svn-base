class asterisk {
    class deploy {
        # ensure that all packages are installed.
#        $packagelist = ["asterisk"]
#        package { $packagelist:
#            ensure => "installed"
#        }

	# ensure services are running.
        service { "asterisk":
        enable      => "true",
        ensure      => "running",
        hasrestart  => "true",
        hasstatus   => "true",
#        require     => Package["asterisk"]
        }
    

       file { "/etc/asterisk/sip.d" :
            ensure      => directory,
            owner       => root,
            group       => root,
            mode        => 644,
#           require     => Package["asterisk"],
	    notify  => Service["asterisk"]
        }

        file { "/etc/asterisk/extensions.d" :
            ensure      => directory,
            owner       => root,
            group       => root,
            mode        => 644,
#            require     => Package["asterisk"],
	    notify  => Service["asterisk"]
        }

	
       file { "/etc/asterisk/sip.conf" :
            ensure      => present,
            owner       => root,
            group       => root,
            mode        => 644,
	    source	=> "puppet:///asterisk/sip.conf",		
#           require     => Package["asterisk"],
	    notify  => Service["asterisk"]
        }
	
	
       file { "/etc/asterisk/extensions.conf" :
            ensure      => present,
            owner       => root,
            group       => root,
            mode        => 644,
            source      => "puppet:///asterisk/extensions.conf",
#           require     => Package["asterisk"],
	    notify  => Service["asterisk"]
        }

	}
    define asterisk_conf ($exten, $sec) {
	
	file { "/etc/asterisk/sip.d/sip-$exten.conf":
            content => template("asterisk/sip.d/sip.conf.erb"),
            notify  => Service["asterisk"]
	}
    	file { "/etc/asterisk/extensions.d/extensions-$exten.conf":
	    content => template("asterisk/extensions.d/extensions.conf.erb"),
  	    notify  => Service["asterisk"]
        }
   }

}
