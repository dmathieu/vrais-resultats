describe Elections::Dataset do
  it "loads the file" do
    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries).to be_a(Enumerator::Lazy)
  end

  it "can't load an unknown format" do
    d = described_class.new("spec/fixtures/dataset_unknown_format.json")
    expect do
      d.entries.first
    end.to raise_error("unknown format n/a")
  end

  it "loads fetches an entry's content" do
    stub_request(:get, "https://example.com")
      .to_return(status: 200, body: file_fixture("municipales.xlsx"), headers: {})

    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.entries.first.content).not_to be_empty
  end

  describe "with local loading" do
    it "loads with no HTTP call" do
      d = described_class.new("datasets.json", local: true)
      expect(d.entries.first).to be_a(Elections::Dataset::XlsxEntry)
    end
  end
end
