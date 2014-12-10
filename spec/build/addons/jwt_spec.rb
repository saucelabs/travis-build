require 'spec_helper'

describe Travis::Build::Addons::Jwt, :sexp do
  let(:script) { stub('script') }
  let(:config) { { username: 'username', access_key: 'access_key' } }
  let(:data)   { payload_for(:push, :ruby, config: { addons: { jwt: config } }) }
  let(:sh)     { Travis::Shell::Builder.new }
  let(:addon)  { described_class.new(script, sh, Travis::Build::Data.new(data), config) }
  subject      { sh.to_sexp }
  before       { addon.before_before_script }

  #it_behaves_like 'compiled script' do
  #  let(:code) { ['jwt_token', 'TRAVIS_JWT_TOKEN=true'] }
  #end

  shared_examples_for 'initializes jwt token' do
    it { should include_sexp [:echo, 'Initializing JWT', ansi: :yellow] }
    # it { should include_sexp [:cmd, 'curl -L https://gist.githubusercontent.com/henrikhodne/9322897/raw/sauce-connect.sh | bash'] }
    # it { should include_sexp [:cmd, 'curl -L https://gist.githubusercontent.com/henrikhodne/9322897/raw/sauce-connect.sh | bash', echo: true, timing: true] }
    #it { should include_sexp [:export, ['TRAVIS_JWT_TOKEN', 'true']] }
  end

  describe 'without credentials' do
    let(:config) { {} }

    it_behaves_like 'initializes jwt token'
  end

  #describe 'with username and access key' do
    #let(:config) { { :username => 'username', :access_key => 'access_key' } }

    #it { should include_sexp [:export, ['JWT_ACCESS_KEY', 'access_key']] }

    #it_behaves_like 'initializes jwt token'
    #it { store_example }
  #end
end

