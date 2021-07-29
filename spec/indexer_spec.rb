describe VR::Indexer do
  let(:content) { JSON.parse(file_fixture("reduced.json")).deep_symbolize_keys }
  subject { described_class.new(content) }

  describe "run" do
    it "creates an event" do
      expect do
        subject.run
      end.to change(Event, :count).by(1)
    end

    it "does not duplicates events" do
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
      end.to change(Area, :count).by(17)
    end

    it "inserts the results" do
      expect do
        subject.run
      end.to change(Result, :count).by(34)
    end
  end
end
