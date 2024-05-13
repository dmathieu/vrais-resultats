# frozen_string_literal: true

describe VR::Reducer::Europeennes::Annee2019 do
  subject { described_class.new({ name: 'europeennes' }, mapper) }

  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) do
    {
      data: [
        {
          name: 'Résultats',
          url: 'https://example.com/resultats'
        }
      ],
      format: 'xls'
    }
  end

  before do
    stub_request(:get, 'https://example.com/resultats')
      .to_return(status: 200, body: file_fixture('europeennes_2019/resultats.xls'), headers: {})
  end

  describe 'new' do
    it 'turns a content array into a hash' do
      expect(subject.content).not_to be_empty
      expect(subject.content[:data].length).to be(19)
      expect(subject.content[:data][0].keys).to eql(%i[name path resultats])
      expect(subject.content[:data][0][:resultats].length).to be(1)
    end
  end
end
