# frozen_string_literal: true

describe VR::Reducer::Regionales::Annee2021 do
  subject { described_class.new({ name: 'regionales' }, mapper) }

  let(:mapper) { VR::Mapper::Roo.new(config) }
  let(:config) do
    {
      data: [
        {
          name: '1er tour',
          url: 'https://example.com/tour-1'
        },
        {
          name: '2e tour',
          url: 'https://example.com/tour-2'
        }
      ],
      format: 'xlsx'
    }
  end

  before do
    stub_request(:get, 'https://example.com/tour-1')
      .to_return(status: 200, body: file_fixture('regionales_2021/tour-1.xlsx'), headers: {})
    stub_request(:get, 'https://example.com/tour-2')
      .to_return(status: 200, body: file_fixture('regionales_2021/tour-2.xlsx'), headers: {})
  end

  describe 'new' do
    it 'turns a content array into a hash' do
      expect(subject.content).not_to be_empty
      expect(subject.content[:data].length).to be(17)
      expect(subject.content[:data][0].keys).to eql(%i[name path resultats])
      expect(subject.content[:data][0][:resultats].length).to be(2)
    end
  end
end
