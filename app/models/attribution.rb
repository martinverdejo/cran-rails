class Attribution < ApplicationRecord

  belongs_to :person
  belongs_to :version

  accepts_nested_attributes_for :person

end
