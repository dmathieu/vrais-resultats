describe VR::Mapper::Roo do
  subject { described_class.new({url:}) }
  let(:url) { "https://example.com" }

  describe "with xlsx data" do
    let(:data) { file_fixture("municipales_2020/tour-1.xlsx") }

    it "loads the data" do
      stub_request(:get, url)
        .to_return(status: 200, body: data, headers: {})

      expect(subject).to be_a(VR::Mapper::Roo)
    end
  end

  describe "with xls data" do
    let(:data) { file_fixture("presidentielles_2017/tour-1.xls") }

    it "loads the data" do
      stub_request(:get, url)
        .to_return(status: 200, body: data, headers: {})

      expect(subject).to be_a(VR::Mapper::Roo)
    end
  end
end
