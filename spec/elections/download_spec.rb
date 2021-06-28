describe Elections::Download do
  it "retrieves the downloaded content" do
    stub_request(:get, "https://example.com")
      .to_return(status: 200, body: "Hello World", headers: {})

    content = described_class.new("https://example.com")
    expect(content.data.read).to eql("Hello World")
  end
end
