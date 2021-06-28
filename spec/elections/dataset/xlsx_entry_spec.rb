describe Elections::Dataset::XlsxEntry do
  subject { described_class.new(data) }
  let(:data) { file_fixture("municipales.xlsx") }

  it "loads the data" do
    expect(subject).to be_a(Elections::Dataset::XlsxEntry)
  end
end
