describe Elections::Dataset do
  it "loads the file" do
    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries.length).to eql(2)
  end

  it "can't load an unknown format" do
    d = described_class.new("spec/fixtures/dataset_unknown_format.json")
    expect do
      d.entries[0]
    end.to raise_error("unknown format n/a")
  end

  it "loads fetches an entry's content" do
    stub_request(:get, "https://example.com")
      .to_return(status: 200, body: file_fixture("sample.xlsx").read, headers: {})

    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries[0].content).not_to be_empty
  end
end
