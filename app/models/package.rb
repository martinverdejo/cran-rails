class Package < ApplicationRecord

  has_many :versions, inverse_of: :package

end
