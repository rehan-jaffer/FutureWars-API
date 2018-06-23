require 'rails_helper'

describe AuthenticateUser do
  before(:all) do
    FactoryGirl.create(:player, username: 'testpassword', password: 'password')
  end

  subject(:context) { described_class.call(username, password) }

  describe '.call' do
    let(:username) { 'testpassword' }
    let(:password) { 'password' }

    it 'succeeds' do
      expect(context).to be_success
    end
  end
end
