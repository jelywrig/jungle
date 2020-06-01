require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'password & confirm password' do
      it 'should be valid if password and confirmation match' do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
        expect(user).to be_valid
      
      end
      it "should throw a doesn't match Password error if they do not match " do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "wrongpassword")
        user.valid?
        expect(user.errors[:password_confirmation]).to include  ("doesn't match Password")
      end
      it "should throw a can't be blank error if password missing" do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password: nil, password_confirmation: "password")
        user.valid?
        expect(user.errors[:password]).to include ("can't be blank")
      end 
      it "should throw a can't be blank error if password confirmation is missing" do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to include ("can't be blank")
      end
      it "should fail if the password is less than 6 characters" do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"pass", password_confirmation: "pass")
        user.valid?
        expect(user.errors[:password]).to include ("is too short (minimum is 6 characters)")
        
      end

    end
    context 'email' do
      it "should throw a can't be blank error if email is missing" do
        user = User.new(first_name: "Test", last_name: "User", email: nil, password:"password", password_confirmation: "password")     
        user.valid?
        expect(user.errors[:email]).to include ("can't be blank")
      end
      it "should not allow duplicate email(case insenstive)" do
        user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
        user.save
        user2 = User.new(first_name: "Test", last_name: "User", email: "EMAIL@example.com", password:"password", password_confirmation: "password")
        user2.valid?
        expect(user2.errors[:email]).to include ("has already been taken")
      end
    end
  end
  describe '.authenticate_with_credentials' do
    it "should return user if correct credentials provided" do
      user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
      user.save
      returnedVal = User.authenticate_with_credentials("email@example.com", "password");
      expect(returnedVal.eql?(user))
    end
    it "should return nill if incorrect password provided" do
      user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
      user.save
      returnedVal = User.authenticate_with_credentials("email@example.com", "wrongpassword");
      expect(returnedVal).to be nil
    end
    it "should return nill if non existant email provided" do
      user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
      user.save
      returnedVal = User.authenticate_with_credentials("nope@example.com", "password");
      expect(returnedVal).to be nil
    end
    it "should return user if leading/trailing spaces on email" do
      user = User.new(first_name: "Test", last_name: "User", email: "email@example.com", password:"password", password_confirmation: "password")
      user.save
      returnedVal = User.authenticate_with_credentials(" email@example.com ", "password");
      expect(returnedVal.eql?(user))
    end

    it "should return user if case mismatch in email (eXample@domain.COM, EXAMple@DOMAIN.CoM)" do
      user = User.new(first_name: "Test", last_name: "User", email: "eXample@domain.COM", password:"password", password_confirmation: "password")
      user.save
      returnedVal = User.authenticate_with_credentials("EXAMple@DOMAIN.CoM", "password");
      expect(returnedVal.eql?(user))
    end
  end
end