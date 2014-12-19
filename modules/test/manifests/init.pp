class test{
	file {
		"/tmp/$hostname.txt": content => "Hello World!\nHello Puppet\n";

	}
}
