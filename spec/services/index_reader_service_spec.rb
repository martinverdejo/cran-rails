require 'rails_helper'

RSpec.describe IndexReaderService, type: :service do

  subject(:service) { described_class.new }

  let(:response) { instance_double(Net::HTTPOK) }
  let(:packages_html) {
    <<-HTML
      Package: A3
      Version: 1.0.0
      Depends: R (>= 2.15.0), xtable, pbapply
      Suggests: randomForest, e1071
      License: GPL (>= 2)
      MD5sum: 027ebdd8affce8f0effaecfcd5f5ade2
      NeedsCompilation: no

      Package: aaSEA
      Version: 1.1.0
      Depends: R(>= 3.4.0)
      Imports: DT(>= 0.4), networkD3(>= 0.4), shiny(>= 1.0.5),
              shinydashboard(>= 0.7.0), magrittr(>= 1.5), Bios2cor(>= 2.0),
              seqinr(>= 3.4-5), plotly(>= 4.7.1), Hmisc(>= 4.1-1)
      Suggests: knitr, rmarkdown
      License: GPL-3
      MD5sum: 0f9aaefc1f1cf18b6167f85dab3180d8
      NeedsCompilation: no
    HTML
  }

  before do
    expect(Net::HTTP).to receive(:start).and_return(response)
    expect(response).to receive(:body).and_return(packages_html)
  end

  describe '#packages' do
    it do
      expect(service.packages).to eq ([
        { "Package"=>"A3", "Version"=>"1.0.0", "Depends"=>"R (>= 2.15.0), xtable, pbapply", "Suggests"=>"randomForest, e1071", "License"=>"GPL (>= 2)", "MD5sum"=>"027ebdd8affce8f0effaecfcd5f5ade2", "NeedsCompilation"=>false },
        { "Package"=>"aaSEA", "Version"=>"1.1.0", "Depends"=>"R(>= 3.4.0)", "Imports"=>"DT(>= 0.4), networkD3(>= 0.4), shiny(>= 1.0.5), shinydashboard(>= 0.7.0), magrittr(>= 1.5), Bios2cor(>= 2.0), seqinr(>= 3.4-5), plotly(>= 4.7.1), Hmisc(>= 4.1-1)", "Suggests"=>"knitr, rmarkdown", "License"=>"GPL-3", "MD5sum"=>"0f9aaefc1f1cf18b6167f85dab3180d8", "NeedsCompilation"=>false }
      ])
    end
  end

  describe '.packages' do
    it do
      expect(described_class.packages).to eq ([
        { "Package"=>"A3", "Version"=>"1.0.0", "Depends"=>"R (>= 2.15.0), xtable, pbapply", "Suggests"=>"randomForest, e1071", "License"=>"GPL (>= 2)", "MD5sum"=>"027ebdd8affce8f0effaecfcd5f5ade2", "NeedsCompilation"=>false },
        { "Package"=>"aaSEA", "Version"=>"1.1.0", "Depends"=>"R(>= 3.4.0)", "Imports"=>"DT(>= 0.4), networkD3(>= 0.4), shiny(>= 1.0.5), shinydashboard(>= 0.7.0), magrittr(>= 1.5), Bios2cor(>= 2.0), seqinr(>= 3.4-5), plotly(>= 4.7.1), Hmisc(>= 4.1-1)", "Suggests"=>"knitr, rmarkdown", "License"=>"GPL-3", "MD5sum"=>"0f9aaefc1f1cf18b6167f85dab3180d8", "NeedsCompilation"=>false }
      ])
    end
  end
end
