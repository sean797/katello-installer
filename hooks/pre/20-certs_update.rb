require 'fileutils'

SSL_BUILD_DIR = '/root/ssl-build/'

def mark_for_update(cert_name, hostname = nil)
  path = File.join(*[SSL_BUILD_DIR, hostname, cert_name].compact)
  puts "Marking certificate #{path} for update"
  FileUtils.touch("#{path}.update")
end

if param('capsule_certs', 'capsule_fqdn')
  hostname = param('capsule_certs', 'capsule_fqdn').value
else
  hostname = param('certs', 'node_fqdn').value
end

if app_value('certs_update_server')
  mark_for_update("#{hostname}-apache", hostname)
  mark_for_update("#{hostname}-foreman-proxy", hostname)
end

if app_value('certs_update_default_ca')
  unless module_enabled?('katello')
    $stderr.puts("--capsule-update-default-ca needs to be used with katello-installer")
    exit 1
  end
  mark_for_update('katello-default-ca')
end

if app_value('certs_update_all') || app_value('certs_update_default_ca')
  all_cert_names = Dir.glob(File.join(SSL_BUILD_DIR, hostname, '*.noarch.rpm')).map do |rpm|
    File.basename(rpm).sub(/-1\.0-\d+\.noarch\.rpm/, '')
  end.uniq

  all_cert_names.each do |cert_name|
    mark_for_update(cert_name, hostname)
  end
end

if app_value('certs_update_server_ca')
  mark_for_update('katello-server-ca')
end

# if app_value(:reset) && !app_value(:noop)

