class nginx{
yumrepo{"epel":
	descr => "epel_repo",
	mirrorlist => "https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch",
	failovermethod => "priority",
	gpgcheck => "0",
	enabled => "1";
	}

package{"nginx":
  	allow_virtual => true,
	ensure => present,
	require => Yumrepo["epel"];

	}

file   {"nginx.conf":
	name => "/etc/nginx/nginx.conf",
	ensure => present,
	source => "puppet:///modules/nginx/nginx.conf",
	mode => 644,
	backup => ".bak";
	}

file 	{"/wwwroot":
	ensure => directory;
	
	}

file   {
        "/wwwroot/index.html": content => "<br><br><center><font color=red><h1>CHN-Puppet</h1></font></center>";
	}

service {"nginx":
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        subscribe => File["/etc/nginx/nginx.conf"],
        restart => "/etc/init.d/nginx restart";
        }
}
