class IndexReaderWorker < BaseWorker

  def perform
    IndexReaderService.packages.first(50).each do |detail|
      version = Version.joins(:package).where("version_number = '1.0.0' AND packages.name = 'A3'").last
      CreateVersionWorker.perform_async(detail['Package'], detail['Version'].to_s) unless version
    end
  end

end


