describe VR::Mapper::Xlsx do
  subject { described_class.new({url: url, slug: "test"}) }
  let(:url) { "https://example.com" }
  let(:data) { file_fixture("municipales_2020/tour-1.xlsx") }

  it "loads the data" do
    stub_request(:get, url)
      .to_return(status: 200, body: data, headers: {})

    expect(subject).to be_a(VR::Mapper::Xlsx)
  end
end
