require 'rails_helper'

RSpec.describe Version, type: :model do
  it { is_expected.to belong_to(:package).inverse_of(:versions) }
  it { is_expected.to have_many(:author_attributions).class_name('Attribution') }
  it { is_expected.to have_many(:authors).through(:author_attributions).source(:person) }
  it { is_expected.to have_many(:maintainer_attributions) }
  it { is_expected.to have_many(:maintainers).through(:maintainer_attributions).source(:person) }
end
