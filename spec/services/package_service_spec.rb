require 'rails_helper'

RSpec.describe PackageService, type: :service do

  let(:package_name) { 'A3' }
  let(:version) { '1.0.0' }

  subject(:service) { described_class.new(package_name, version) }

  let(:tar_entry) { instance_double(Gem::Package::TarReader::Entry) }
  let(:description_text) {
    <<-TEXT
      Package: A3
      Type: Package
      Title: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models
      Version: 1.0.0
      Date: 2015-08-15
      Author: Scott Fortmann-Roe
      Maintainer: Scott Fortmann-Roe <scottfr@berkeley.edu>
      Description: Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.
      License: GPL (>= 2)
      Depends: R (>= 2.15.0), xtable, pbapply
      Suggests: randomForest, e1071
      NeedsCompilation: no
      Packaged: 2015-08-16 14:17:33 UTC; scott
      Repository: CRAN
      Date/Publication: 2015-08-16 23:05:52
    TEXT
  }

  before do
    expect(Gem::Package::TarReader).to receive_message_chain(:new, :detect).and_return(tar_entry)
    expect(tar_entry).to receive(:read).and_return(description_text)
  end

  describe '#describe' do
    it do
      expect(service.describe).to eq({
        "Package"=>"A3",
        "Type"=>"Package",
        "Title"=>"Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
        "Version"=>"1.0.0",
        "Date"=>Date.parse("Sat, 15 Aug 2015"),
        "Author"=>"Scott Fortmann-Roe",
        "Maintainer"=>"Scott Fortmann-Roe <scottfr@berkeley.edu>",
        "Description"=>"Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
        "License"=>"GPL (>= 2)",
        "Depends"=>"R (>= 2.15.0), xtable, pbapply",
        "Suggests"=>"randomForest, e1071",
        "NeedsCompilation"=>false,
        "Packaged"=>"2015-08-16 14:17:33 UTC; scott",
        "Repository"=>"CRAN",
        "Date/Publication"=>Time.parse("2015-08-17 07:05:52 +0800")
      })
    end
  end

  # describe '.describe' do
  #   it do
  #     expect(described_class.describe(package_name, version)).to eq({
  #       "Package"=>"A3",
  #       "Type"=>"Package",
  #       "Title"=>"Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
  #       "Version"=>"1.0.0",
  #       "Date"=>Sat, 15 Aug 2015, "Author"=>"Scott Fortmann-Roe",
  #       "Maintainer"=>"Scott Fortmann-Roe <scottfr@berkeley.edu>",
  #       "Description"=>"Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
  #       "License"=>"GPL (>= 2)",
  #       "Depends"=>"R (>= 2.15.0), xtable, pbapply",
  #       "Suggests"=>"randomForest, e1071",
  #       "NeedsCompilation"=>false, "Packaged"=>"2015-08-16 14:17:33 UTC; scott",
  #       "Repository"=>"CRAN",
  #       "Date/Publication"=>2015-08-17 07:05:52 +0800
  #     })
  #   end
  # end
end
