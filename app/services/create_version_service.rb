class CreateVersionService < BaseService

  validate :package_exists

  def initialize(name, version)
    @name, @version = name, version
    @package = Package.find_or_initialize_by(name: @name)
    @version = @package.versions.build(attribute_parser.version_attributes)
    @errors = ActiveModel::Errors.new(self)
  end

  def run
    if valid?
      Version.transaction do
        @version.save!

        attribute_parser.existing_authors.each { |person| @version.author_attributions.create!(person: person, attribution_type: 'author') }
        attribute_parser.existing_maintainers.each.each { |person| @version.maintainer_attributions.create!(person: person, attribution_type: 'maintainer') }

        attribute_parser.new_authors.each { |person| @version.author_attributions.create!(person: Person.create!(person), attribution_type: 'author') }
        attribute_parser.new_maintainers.each { |person| @version.maintainer_attributions.create!(person: Person.create!(person), attribution_type: 'maintainer') }
      end
    end
    errors.empty?
  end

  private

  def package_exists
    errors.add(:base, 'Package not found') if @package.nil?
  end

  def attribute_parser
    VersionAttributesService.new(description)
  end

  def description
    @desciption ||= PackageService.describe(@name, @version)
  end

end
