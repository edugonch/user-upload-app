require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#password' do
    describe 'strong password' do
      it 'should success on Aqpfk1swods' do
        user = User.new(name: 'John Doe', password: 'Aqpfk1swods')
        expect(user).to be_valid
      end

      it 'should success on QPFJWz1343439' do
        user = User.new(name: 'John Doe', password: 'QPFJWz1343439')
        expect(user).to be_valid
      end

      it 'should success on PFSHH78KSMa' do
        user = User.new(name: 'John Doe', password: 'PFSHH78KSMa')
        expect(user).to be_valid
      end
    end

    describe 'weak password' do
      it 'should fail at Abc123' do
        user = User.new(name: 'John Doe', password: 'Abc123')
        expect(user).to be_invalid
      end

      it 'should fail at abcdefghijklmnop' do
        user = User.new(name: 'John Doe', password: 'abcdefghijklmnop')
        expect(user).to be_invalid
      end

      it 'should fail at AAAfk1swods' do
        user = User.new(name: 'John Doe', password: 'AAAfk1swods')
        expect(user).to be_invalid
      end
    end
  end

  describe '#name' do
    it 'should be present' do
      user = User.new(password: 'Aqpfk1swods')
      expect(user).to be_invalid
    end
  end
end
