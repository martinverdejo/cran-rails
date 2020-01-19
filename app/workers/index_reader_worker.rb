class IndexReaderWorker < BaseWorker

  def perform
    IndexReaderService.packages.each do |detail|
      CreatePackageWorker.perform_async(detail['Package'], detail['Version'])
    end
  end

end


