require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "must have a valid email" do
      user = User.new(full_name: "testy mctestface", email: "test@example.com")
      user.password = '12345678'
      expect(user.valid?).to eq true
      user2 = User.new(full_name: "testy mctestface", email: "sdfsdfsdf")
      user2.password = '12345678'
      expect(user2.valid?).to eq false
    end

    it "must have at least an 8 character long password" do
      user = User.new(full_name: "testy mctestface", email: "test@example.com")
      user.password = '1234567'
      expect(user.valid?).to eq false
      user2 = User.new(full_name: "testy mctestface", email: "test@example.com")
      user2.password = '12345678'
      expect(user2.valid?).to eq true
    end

    it "requires a password for email users" do
      user = User.new(authentication_type: "email")
      expect(user.validate_password?).to eq true
      user2 = User.new(authentication_type: "facebook")
      expect(user2.validate_password?).to eq false
    end
  end
end
