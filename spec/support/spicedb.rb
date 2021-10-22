RSpec.shared_context 'unique token' do
  let(:unique_token) { |example| [example.description.split(' '), rand(1000)].flatten.join('_') }
end

RSpec.configure do |config|
  config.include_context "unique token", :with_unique_tokens
end
