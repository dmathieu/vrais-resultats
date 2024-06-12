# frozen_string_literal: true

describe VR::Reducer::Europeennes::Annee2024 do
  let(:reducer) { described_class.new({ name: 'europeennes' }, mapper) }

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
      .to_return(status: 200, body: file_fixture('europeennes_2024/resultats.xls'), headers: {})
  end

  describe 'new' do
    it 'turns a content array into a hash' do
      expect(reducer.content).not_to be_empty
      expect(reducer.content[:data].length).to be(1)
      expect(reducer.content[:data][0].keys).to eql(%i[name path resultats])
      expect(reducer.content[:data][0][:resultats].length).to be(1)
    end
  end
end
