# Add reset option
app_option(
  '--certs-update-server',
  :flag,
  "This options will enforce to update of the https certificates for given host",
  :default => false
)
app_option(
  '--certs-update-server-ca',
  :flag,
  "This options will enforce to update of the CA used for https certificates",
  :default => false
)
app_option(
  '--certs-update-default-ca',
  :flag,
  "This options will enforce to update of the default CA (used for client certificates).
   This also implicates --certs-update-all. After doing so, one should also run
   capsule-certs-generate --certs-update-all for every capsule in the infrastructure",
  :default => false
)
app_option(
  '--certs-update-all',
  :flag,
  "This options will enforce to update of all the certificates for given host",
  :default => false
)
