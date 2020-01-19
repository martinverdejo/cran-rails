class CreatePackageWorker < BaseWorker

  def perform(package_name, version)
    description = PackageService.describe(package_name, version)
  end

end


