describe Elections::Renderer do
  describe "new" do
    it "can't create unknown renderers" do
      expect do
        described_class.new("foobar", [])
      end.to raise_error("unknown renderer foobar")
    end

    it "creates a municipales renderer" do
      expect(described_class.new("municipales", [])).to be_a(Elections::Renderer::Municipales)
    end
  end
end
