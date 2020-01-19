class VersionAttributesService < BaseService

  def initialize(description)
    @description = description
  end

  def version_attributes
    {
      version_number: @description['Version'],
      title: @description['Title'],
      description: @description['Description'],
      date_publication: @description['Date/Publication']
    }
  end

  def existing_authors
    @existing_authors ||= Person.where("lower(name) in (?) OR lower(email) in (?)", description_author_names, description_author_emails)
  end

  def existing_maintainers
    @existing_maintainers ||= Person.where("lower(name) in (?) OR lower(email) in (?)", description_maintainer_names, description_maintainer_emails)
  end

  def new_authors
    description_author_attributes.map do |author|
      author unless author[:name].in?(exsiting_author_names) || author[:email].in?(exsiting_author_emails)
    end.compact
  end

  def new_maintainers
    description_maintainer_attributes.map do |maintainer|
      maintainer unless maintainer[:name].in?(exsiting_maintainer_names) || maintainer[:email].in?(exsiting_maintainer_emails)
    end.compact
  end

  private

  def exsiting_author_names
    @exsiting_author_names ||= existing_authors.pluck(:name)
  end

  def exsiting_author_emails
    @exsiting_author_emails ||= existing_authors.pluck(:email)
  end

  def description_author_names
    @description_author_names ||= description_author_attributes.map { |a| a[:name]&.downcase }.compact
  end

  def description_author_emails
    @description_author_emails ||= description_author_attributes.map { |a| a[:email]&.downcase }.compact
  end

  def description_author_attributes
    @description["Author"].gsub(/\[.*?\]/, '').split(',').map do |detail|
      {
        email: detail.strip[/\<(.*?)\>/m, 1],
        name: detail.strip.split('<').first.strip
      }
    end
  end

  def exsiting_maintainer_names
    @exsiting_maintainer_names ||= existing_maintainers.pluck(:name)
  end

  def exsiting_maintainer_emails
    @exsiting_maintainer_emails ||= existing_maintainers.pluck(:email)
  end

  def description_maintainer_names
    @description_maintainer_names ||= description_maintainer_attributes.map { |a| a[:name]&.downcase }.compact
  end

  def description_maintainer_emails
    @description_maintainer_emails ||= description_maintainer_attributes.map { |a| a[:email]&.downcase }.compact
  end

  def description_maintainer_attributes
    @description["Maintainer"].gsub(/\[.*?\]/, '').split(',').map do |detail|
      {
        email: detail.strip[/\<(.*?)\>/m, 1],
        name: detail.strip.split('<').first.strip
      }
    end
  end

end
