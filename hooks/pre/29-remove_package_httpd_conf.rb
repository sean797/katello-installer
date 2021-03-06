# Some packages like pulp place configuration files in /etc/httpd/conf.d that
# contain duplicates declarations of directives that the puppetlabs-apache
# module configured elsewhere.
#
# * pulp places a pulp.conf that contains a duplicate WSGI 'pulp'
#   daemon that 05-pulps-https.conf contains.
#
%w(pulp.conf).each do |file|
  File.delete(File.join("/etc/httpd/conf.d/", file)) if File.file?(File.join("/etc/httpd/conf.d/", file))
end
