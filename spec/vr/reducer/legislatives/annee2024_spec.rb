# frozen_string_literal: true

describe VR::Reducer::Legislatives::Annee2024 do
  let(:reducer) { described_class.new({ name: 'legislatives' }, mapper) }

  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) do
    {
      data: [
        {
          name: '1er tour',
          url: 'https://example.com/tour-1'
        }
      ],
      format: 'xlsx'
    }
  end

  before do
    stub_request(:get, 'https://example.com/tour-1')
      .to_return(status: 200, body: file_fixture('legislatives_2024/tour-1.xlsx'), headers: {})
  end

  describe 'new' do
    it 'turns a content array into a hash' do
      expect(reducer.content).not_to be_empty
      expect(reducer.content[:data].length).to eq(49)
      expect(reducer.content[:data][0].keys).to eql(%i[name path resultats])
      expect(reducer.content[:data][0][:resultats].length).to eq(1)
    end
  end
end
