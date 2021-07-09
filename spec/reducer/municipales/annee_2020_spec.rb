describe VR::Reducer::Municipales::Annee2020 do
  subject { described_class.new({name: "municipales"}, mapper) }
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
      slug: "test",
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

  describe "new" do
    it "turns a content array into a hash" do
      expect(subject.content).not_to be_empty
      expect(subject.content[:data].length).to eql(4)
      expect(subject.content[:data][0].keys).to eql([:breadcrumb, :name, :resultats])
      expect(subject.content[:data][0][:resultats].length).to eql(1)
    end
  end

  describe "update_candidats" do
    it "creates an array of candidats" do
      entry = ["01", "Ain", "012", "Aranc", "0001", 273, 120, 43.96, 153, 56.04, 1, 0.37, 0.65, 2, 0.73, 1.31, 150, 54.95, 98.04, 7, "NC", "M", "PIRES", "Herve", nil, 0, 0, 0, 11, "NC", "M", "GOYET", "Eric", nil, 62, 22.71, 41.33, 13, "NC", "F", "PALLET", "Monique", nil, 88, 32.23, 58.67, 14, "NC", "F", "TRICHARD", "Elodie", nil, 0, 0, 0, 15, "NC", "M", "DAVID", "Guy", nil, 0, 0, 0, 16, "NC", "F", "DAVID", "Brigitte", nil, 0, 0, 0, 17, "NC", "M", "CABAUSSEL", "Michel", nil, 0, 0, 0, 18, "NC", "M", "DESVIGNE", "Joan", nil, 0, 0, 0, 20, "NC", "F", "BOUTEILLE", "Solene", nil, 0, 0, 0]
      data = subject.send(:update_candidats, [], entry)
      expect(data).to eql([
        {liste: "", nom: "PIRES", prenom: "Herve", voix: 0},
        {liste: "", nom: "GOYET", prenom: "Eric", voix: 62},
        {liste: "", nom: "PALLET", prenom: "Monique", voix: 88},
        {liste: "", nom: "TRICHARD", prenom: "Elodie", voix: 0},
        {liste: "", nom: "DAVID", prenom: "Guy", voix: 0},
        {liste: "", nom: "DAVID", prenom: "Brigitte", voix: 0},
        {liste: "", nom: "CABAUSSEL", prenom: "Michel", voix: 0},
        {liste: "", nom: "DESVIGNE", prenom: "Joan", voix: 0},
        {liste: "", nom: "BOUTEILLE", prenom: "Solene", voix: 0}
      ])
    end

    it "handles poorly formatted data" do
      entry = ["01", "Ain", "012", "Aranc", "0001", 273, 120, 43.96, 153, 56.04, 1, 0.37, 0.65, 2, 0.73, 1.31, 150, 54.95, 98.04, 7, "NC", "M", "PIRES", "Herve", "ma liste", "est mal formatée", 0, 0, 0, 11, "NC", "M", "GOYET", "Eric", nil, 62, 22.71, 41.33, 13, "NC", "F", "PALLET", "Monique", nil, 88, 32.23, 58.67, 14, "NC", "F", "TRICHARD", "Elodie", nil, 0, 0, 0, 15, "NC", "M", "DAVID", "Guy", nil, 0, 0, 0, 16, "NC", "F", "DAVID", "Brigitte", nil, 0, 0, 0, 17, "NC", "M", "CABAUSSEL", "Michel", nil, 0, 0, 0, 18, "NC", "M", "DESVIGNE", "Joan", nil, 0, 0, 0, 20, "NC", "F", "BOUTEILLE", "Solene", nil, 0, 0, 0]
      data = subject.send(:update_candidats, [], entry)
      expect(data).to eql([
        {liste: "ma liste est mal formatée", nom: "PIRES", prenom: "Herve", voix: 0},
        {liste: "", nom: "GOYET", prenom: "Eric", voix: 62},
        {liste: "", nom: "PALLET", prenom: "Monique", voix: 88},
        {liste: "", nom: "TRICHARD", prenom: "Elodie", voix: 0},
        {liste: "", nom: "DAVID", prenom: "Guy", voix: 0},
        {liste: "", nom: "DAVID", prenom: "Brigitte", voix: 0},
        {liste: "", nom: "CABAUSSEL", prenom: "Michel", voix: 0},
        {liste: "", nom: "DESVIGNE", prenom: "Joan", voix: 0},
        {liste: "", nom: "BOUTEILLE", prenom: "Solene", voix: 0}
      ])
    end
  end
end
