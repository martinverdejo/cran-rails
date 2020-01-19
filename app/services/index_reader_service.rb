class IndexReaderService < BaseService

  def self.packages
    self.new.packages
  end

  def initialize
    @uri = URI.parse('https://cran.r-project.org/src/contrib/PACKAGES')
  end

  def packages
    package_details = packages_html.body.split("\n\n").collect { |p| YAML.load(p) }
  end

  private

  def packages_html
    Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') { |http| http.request(Net::HTTP::Get.new(@uri)) }
  end

end
