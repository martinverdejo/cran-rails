class CreateVersionWorker < BaseWorker

  def perform(package_name, version)
    CreateVersionService.new(package_name, version).run
  end

end


