describe VR::Reducer::Europeennes::Annee2019 do
  subject { described_class.new({name: "europeennes"}, mapper) }
  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) {
    {
      data: [
        {
          name: "Résultats",
          url: "https://example.com/resultats"
        }
      ],
      slug: "test",
      format: "xls"
    }
  }

  before :each do
    stub_request(:get, "https://example.com/resultats")
      .to_return(status: 200, body: file_fixture("europeennes_2019/resultats.xls"), headers: {})
  end

  describe "new" do
    it "turns a content array into a hash" do
      expect(subject.content).not_to be_empty
      expect(subject.content[:data].length).to eql(19)
      expect(subject.content[:data][0].keys).to eql([:breadcrumb, :name, :resultats])
      expect(subject.content[:data][0][:resultats].length).to eql(1)
    end
  end
end
