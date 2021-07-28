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

      event = Event.last
      expect(event).to be_populated
    end

    it "does not insert a new event" do
      subject.run
      expect do
        subject.run
      end.to change(Event, :count).by(0)
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

    it "inserts the results" do
      expect do
        subject.run
      end.to change(Result, :count).by(15)
    end
  end

  describe "candidates_splitter" do
    it "creates an array of candidats" do
      entry = ["01", "Ain", "012", "Aranc", "0001", 273, 120, 43.96, 153, 56.04, 1, 0.37, 0.65, 2, 0.73, 1.31, 150, 54.95, 98.04, 7, "NC", "M", "PIRES", "Herve", nil, 0, 0, 0, 11, "NC", "M", "GOYET", "Eric", nil, 62, 22.71, 41.33, 13, "NC", "F", "PALLET", "Monique", nil, 88, 32.23, 58.67, 14, "NC", "F", "TRICHARD", "Elodie", nil, 0, 0, 0, 15, "NC", "M", "DAVID", "Guy", nil, 0, 0, 0, 16, "NC", "F", "DAVID", "Brigitte", nil, 0, 0, 0, 17, "NC", "M", "CABAUSSEL", "Michel", nil, 0, 0, 0, 18, "NC", "M", "DESVIGNE", "Joan", nil, 0, 0, 0, 20, "NC", "F", "BOUTEILLE", "Solene", nil, 0, 0, 0]
      data = subject.send(:parse_row, entry)
      expect(data[:candidats]).to eql([
        {liste: nil, nom: "PIRES Herve", voix: 0},
        {liste: nil, nom: "GOYET Eric", voix: 62},
        {liste: nil, nom: "PALLET Monique", voix: 88},
        {liste: nil, nom: "TRICHARD Elodie", voix: 0},
        {liste: nil, nom: "DAVID Guy", voix: 0},
        {liste: nil, nom: "DAVID Brigitte", voix: 0},
        {liste: nil, nom: "CABAUSSEL Michel", voix: 0},
        {liste: nil, nom: "DESVIGNE Joan", voix: 0},
        {liste: nil, nom: "BOUTEILLE Solene", voix: 0}
      ])
    end

    it "handles poorly formatted data" do
      entry = ["01", "Ain", "012", "Aranc", "0001", 273, 120, 43.96, 153, 56.04, 1, 0.37, 0.65, 2, 0.73, 1.31, 150, 54.95, 98.04, 7, "NC", "M", "PIRES", "Herve", "ma liste", "est mal formatée", 0, 0, 0, 11, "NC", "M", "GOYET", "Eric", nil, 62, 22.71, 41.33, 13, "NC", "F", "PALLET", "Monique", nil, 88, 32.23, 58.67, 14, "NC", "F", "TRICHARD", "Elodie", nil, 0, 0, 0, 15, "NC", "M", "DAVID", "Guy", nil, 0, 0, 0, 16, "NC", "F", "DAVID", "Brigitte", nil, 0, 0, 0, 17, "NC", "M", "CABAUSSEL", "Michel", nil, 0, 0, 0, 18, "NC", "M", "DESVIGNE", "Joan", nil, 0, 0, 0, 20, "NC", "F", "BOUTEILLE", "Solene", nil, 0, 0, 0]
      data = subject.send(:parse_row, entry)
      expect(data[:candidats]).to eql([
        {liste: "ma liste est mal formatée", nom: "PIRES Herve", voix: 0},
        {liste: nil, nom: "GOYET Eric", voix: 62},
        {liste: nil, nom: "PALLET Monique", voix: 88},
        {liste: nil, nom: "TRICHARD Elodie", voix: 0},
        {liste: nil, nom: "DAVID Guy", voix: 0},
        {liste: nil, nom: "DAVID Brigitte", voix: 0},
        {liste: nil, nom: "CABAUSSEL Michel", voix: 0},
        {liste: nil, nom: "DESVIGNE Joan", voix: 0},
        {liste: nil, nom: "BOUTEILLE Solene", voix: 0}
      ])
    end
  end
end
