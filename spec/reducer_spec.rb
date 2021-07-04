describe VR::Reducer do
  describe "new" do
    it "can't create unknown reducers" do
      expect do
        described_class.new({reducer: "foobar"}, [])
      end.to raise_error("uninitialized constant VR::Reducer::Foobar")
    end

    it "creates a municipales reducer" do
      expect(described_class.new({reducer: "municipales", annee: 2020}, [])).to be_a(VR::Reducer::Municipales::Annee2020)
    end
  end
end
