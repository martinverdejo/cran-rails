require 'rails_helper'

RSpec.describe Package, type: :model do
  it { is_expected.to have_many(:versions).inverse_of(:package) }
end
