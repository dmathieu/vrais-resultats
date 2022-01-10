describe VR::Reducer do
  describe "new" do
    it "can't create unknown reducers" do
      expect do
        described_class.find({reducer: "foobar"}, double(:mapper))
      end.to raise_error(NameError)
    end

    it "creates a municipales reducer" do
      expect(described_class.find({reducer: "municipales", annee: 2020}, double(:mapper))).to be_a(VR::Reducer::Municipales::Annee2020)
    end
  end
end
