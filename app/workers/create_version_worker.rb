class CreateVersionWorker < BaseWorker

  def perform(name, version)
    CreateVersionService.new(name, version).run
  end

end


