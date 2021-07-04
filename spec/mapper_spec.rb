describe VR::Mapper do
  describe "with a valid dataset" do
    it "loads an xlsx document" do
      d = described_class.new({format: "xlsx"})
      expect(d).to be_a(VR::Mapper::Xlsx)
    end
  end

  describe "with unknown format" do
    it "can't load" do
      expect do
        described_class.new({format: "n/a"})
      end.to raise_error("unknown format n/a")
    end
  end
end
