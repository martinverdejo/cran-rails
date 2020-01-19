require 'rubygems/package'
require 'open-uri'
require 'dcf'

class PackageService < BaseService

  def self.describe(name, version)
    self.new(name, version).describe
  end

  def initialize(name, version)
    @name, @version = name, version
    @uri = "http://cran.r-project.org/src/contrib/#{name}_#{version}.tar.gz"
  end

  def describe
    # YAML.load(description_text.gsub(/\t/, '  '))
    Dcf.parse(description_text).first
  end

  private

  def description_text
    Gem::Package::TarReader.new(Zlib::GzipReader.open(open(@uri))).detect do |file|
      file.full_name == "#{@name}/DESCRIPTION"
    end.read
  end

end
