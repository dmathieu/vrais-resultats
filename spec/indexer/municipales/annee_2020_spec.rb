describe VR::Indexer::Municipales::Annee2020 do
  subject { described_class.new({name: "Municipales 2020"}, mapper) }
  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) {
    {
      data: [
        {
          name: "1er tour",
          url: "https://example.com/tour-1"
        },
        {
          name: "2e tour",
          url: "https://example.com/tour-2"
        }
      ],
      format: "xlsx"
    }
  }
  let(:data) { file_fixture("municipales.xlsx") }

  before :each do
    stub_request(:get, "https://example.com/tour-1")
      .to_return(status: 200, body: file_fixture("municipales_2020/tour-1.xlsx"), headers: {})
    stub_request(:get, "https://example.com/tour-2")
      .to_return(status: 200, body: file_fixture("municipales_2020/tour-2.xlsx"), headers: {})
  end

  describe "run" do
    it "inserts the event" do
      expect do
        subject.run
      end.to change(Event, :count).by(1)
    end

    it "inserts the rounds" do
      expect do
        subject.run
      end.to change(Round, :count).by(2)
    end

    it "inserts the areas" do
      expect do
        subject.run
      end.to change(Area, :count).by(15)
    end
  end
end
