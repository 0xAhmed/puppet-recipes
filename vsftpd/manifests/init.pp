# To change this template, choose Tools | Templates
# and open the template in the editor.


class vsftp {
    class deploy {
        # ensure that all packages are installed.
        $packagelist = ["vsftpd"]
        package { $packagelist:
        ensure => "installed"
        }

        # ensure services are running.
        service { "vsftpd":
        enable      => "true",
	ensure      => "running",
	hasrestart  => "true",
 	hasstatus   => "true",
        require     => Package["vsftpd"]
        }
    }
     class config {
         file { "/etc/vsftpd/vsftpd.conf":
            owner   => "root",
            group   => "root",
            mode    => 644,
            content => template("vsftpd/vsftpd.erb"),
            notify  => Service["vsftpd"]
        }
    }

        define user ($user, $uid, $gid, $passwd, $home="/var/ftp/pub", $shell, $ensure) {
		group { "$user":
			gid	=> "$gid",
			ensure	=> present
		}
		user { "$user" : 
                	uid	 => "$uid",
	        	ensure   => "$ensure",
    			gid      => "$gid",
   	        	password   => "$passwd",
	        	home     => "$home",
    			shell    => "$shell"
		}
   }
	define vsftp_anon ($anon_enable, $anon_upload) {
        file { "/etc/vsftpd/vsftpd.conf":
	    content => template("vsftpd/vsftpd.erb"),
            notify => Service["vsftpd"]
    }
}
}
