describe VR::Indexer do
  describe "new" do
    it "creates a presidentielles indexer" do
      expect(described_class.new({
        name: "Municipales 2020",
        reducer: "municipales",
        annee: 2020
      }, double(:mapper))).to be_a(VR::Indexer::Municipales::Annee2020)
    end
  end
end
