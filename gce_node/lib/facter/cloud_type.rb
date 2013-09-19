Facter.add("cloud_type") do
  has_weight 100
  setcode do
    # Check for existance of 'cloud_type' and check if it's CernVM
    if File.exists?('/var/lib/cloud_type')
      Facter::Util::Resolution.exec("cat /var/lib/cloud_type")
    else
      #assume it's OpenStack and needs to be written by the contect helper
      Facter::Util::Resolution.exec("echo OpenStack")
    end
  end
end
