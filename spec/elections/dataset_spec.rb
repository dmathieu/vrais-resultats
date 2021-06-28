describe Elections::Dataset do
  it "loads the file" do
    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries.length).to eql(2)
  end

  it "loads fetches an entry's content" do
    stub_request(:get, "https://example.com")
      .to_return(status: 200, body: "Loaded Content", headers: {})

    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries[0].content).to eql("Loaded Content")
  end
end
