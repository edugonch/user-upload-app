require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#password' do
    it 'should be a strong password' do
      user = User.new(name: 'John Doe', password: 'Aqpfk1swods')
      expect(user).to be_valid
    end

    it 'should be a weak password' do
      user = User.new(name: 'John Doe', password: 'Abc123')
      expect(user).to be_invalid
    end

    it 'should not contain three repeating characters in a row' do
      user = User.new(name: 'John Doe', password: 'AAAaa111')
      expect(user).to be_invalid
    end
  end

  describe '#name' do
    it 'should be present' do
      user = User.new(password: 'Aqpfk1swods')
      expect(user).to be_invalid
    end

    it 'should be alphabetic' do
      user = User.new(name: '123', password: 'Aqpfk1swods')
      expect(user).to be_invalid
    end
  end
end
