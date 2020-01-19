require 'rails_helper'

RSpec.describe Attribution, type: :model do
  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:version) }
end
