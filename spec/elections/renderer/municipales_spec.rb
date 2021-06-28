describe Elections::Renderer::Municipales do
  subject { described_class.new(content) }
  let(:content) { Elections::Dataset::XlsxEntry.new({}, file_fixture("municipales.xlsx")).content }

  describe "new" do
    it "turns a content array into a hash" do
      expect(subject.content).not_to be_empty
    end
  end
end
