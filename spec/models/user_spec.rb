require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
  end
end 
