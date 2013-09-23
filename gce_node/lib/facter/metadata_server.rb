require 'ping'

Facter.add("metadata_server") do
  has_weight 100
  setcode do
    # Check for existance of 'cloud_type' and check if it's CernVM
    if Ping.pingecho( '169.254.169.254' )
      Facter::Util::Resolution.exec("echo 169.254.169.254")
    else
      #assume it's OpenStack and needs to be written by the contect helper
      Facter::Util::Resolution.exec("echo false")
    end
  end
end
