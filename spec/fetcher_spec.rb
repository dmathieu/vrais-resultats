describe VR::Fetcher do
  let(:config) {
    {
      slug: "test-fetcher",
      format: "txt",
      data: [
        {
          name: "Tour unique",
          url: "https://example.com"
        }
      ]
    }
  }

  it "retrieves the downloaded content" do
    stub_request(:get, "https://example.com")
      .to_return(status: 200, body: "Hello World", headers: {})

    content = described_class.fetch(config)
    expect(content.length).to eql(1)
    expect(File.read(content[0][:path])).to eql("Hello World")
  end
end
