describe VR::Dataset do
  before do
    allow(VR::Fetcher).to receive(:fetch) do |arg|
      arg[:data].map do |v|
        case arg[:format]
        when "xlsx"
          {name: "Tour unique", path: "spec/fixtures/municipales_2020/tour-1.xlsx"}
        when "xls"
          {name: "Tour unique", path: "spec/fixtures/presidentielles_2017/tour-1.xls"}
        else
          raise "unknown format #{arg[:format]}"
        end
      end
    end
  end

  it "loads the config" do
    d = described_class.new("spec/fixtures/dataset.json")
    expect(d.config).not_to be_empty
  end

  it "can loop through all entries" do
    d = described_class.new("spec/fixtures/dataset.json")
    d.each do |r|
      expect(r).not_to be_nil
    end
  end
end
