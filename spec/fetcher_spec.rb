# frozen_string_literal: true

describe VR::Fetcher do
  let(:config) do
    {
      format: 'txt',
      data: [
        {
          name: 'Tour unique',
          url: 'https://example.com'
        }
      ]
    }
  end

  it 'retrieves the downloaded content' do
    stub_request(:get, 'https://example.com')
      .to_return(status: 200, body: 'Hello World', headers: {})

    content = described_class.fetch(config)
    expect(content.length).to be(1)
    expect(File.read(content[0][:path])).to eql('Hello World')
  end
end
