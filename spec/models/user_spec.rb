require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "must have a valid email" do
      user = User.new(email: "test@example.com")
      user.password = '12345678'
      expect(user.valid?).to eq true
      user2 = User.new(email: "sdfsdfsdf")
      user2.password = '12345678'
      expect(user2.valid?).to eq false
    end

    it "must have at least an 8 character long password" do
      user = User.new(email: "test@example.com")
      user.password = '1234567'
      expect(user.valid?).to eq false
      user2 = User.new(email: "test@example.com")
      user2.password = '12345678'
      expect(user2.valid?).to eq true
    end
  end
end
