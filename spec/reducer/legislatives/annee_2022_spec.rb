describe VR::Reducer::Legislatives::Annee2022 do
  subject { described_class.new({name: "legislatives"}, mapper) }
  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) {
    {
      data: [
        {
          name: "1er tour",
          url: "https://example.com/tour-1"
        }
      ],
      format: "xlsx"
    }
  }

  before :each do
    stub_request(:get, "https://example.com/tour-1")
      .to_return(status: 200, body: file_fixture("legislatives_2022/tour-1.xlsx"), headers: {})
  end

  describe "new" do
    it "turns a content array into a hash" do
      expect(subject.content).not_to be_empty
      expect(subject.content[:data].length).to eql(1)
      expect(subject.content[:data][0].keys).to eql([:name, :path, :resultats])
      expect(subject.content[:data][0][:resultats].length).to eql(1)
    end
  end
end
