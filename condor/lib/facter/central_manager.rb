Facter.add("central_manager") do
  has_weight 100
  setcode do
    # Check for existance of '/etc/condor/central_manager' to get CONDOR_HOST
    if File.exists?('/etc/condor/central_manager')
      Facter::Util::Resolution.exec("cat /etc/condor/central_manager")
    else
      Facter::Util::Resolution.exec("echo localhost")      
    end
  end
end
