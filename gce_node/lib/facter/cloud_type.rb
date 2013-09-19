Facter.add("cloud_type") do
  has_weight 100
  setcode do
    # Check for existance of '/etc/distro-release' and check if it's CernVM
    if File.exists?('/var/lib/cloud_type')
      Facter::Util::Resolution.exec("cat /var/lib/cloud_type")
    end
  end
end