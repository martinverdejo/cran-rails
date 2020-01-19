class Version < ApplicationRecord

  belongs_to :package, inverse_of: :versions

  has_many :author_attributions, -> { where(attribution_type: 'author') }, class_name: 'Attribution', foreign_key: :version_id
  has_many :authors, through: :author_attributions, source: :person

  has_many :maintainer_attributions, -> { where(attribution_type: 'maintainer') }, class_name: 'Attribution', foreign_key: :version_id
  has_many :maintainers, through: :maintainer_attributions, source: :person

  accepts_nested_attributes_for :author_attributions
  accepts_nested_attributes_for :maintainer_attributions

end
