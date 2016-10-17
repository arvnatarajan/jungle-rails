require 'rails_helper'

RSpec.describe User, :type => :feature do
  scenario "Create new user with matching passwords" do
    visit "/users/new"

    fill_in "user[name]", :with => "Bob"
    fill_in "user[email]", :with => "my@email.com"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "1234"

    click_button "Submit"

    expect(page).to have_text("Bob")
  end

  scenario "Create new user with non-matching passwords" do
    visit "/users/new"

    fill_in "user[name]", :with => "Bob"
    fill_in "user[email]", :with => "my@email.com"
    fill_in "user[password]", :with => "12345"
    fill_in "user[password_confirmation]", :with => "1234"

    click_button "Submit"

    expect(page).not_to have_text("Bob")
  end

  context "User Signup" do
    it "verifies that emails are not unique (case insensitive)" do
      @user1 = User.create(name: '1234', email: "test", password:'test', password_confirmation: 'test')
      @user2 = User.create(name: '1234', email: "test", password:'test', password_confirmation: 'test')

      expect(@user2.valid?).to eq(false)
    end

    it "verifies that emails are not unique (case sensitive)" do
      @user1 = User.create(name: '1234', email: "test", password:'test', password_confirmation: 'test')
      @user2 = User.create(name: '1234', email: "TEST", password:'test', password_confirmation: 'test')

      expect(@user2.valid?).to eq(false)
    end

    it "verifies that emails are unique" do
      @user1 = User.create(name: '1234', email: "test", password:'test', password_confirmation: 'test')
      @user2 = User.create(name: '1234', email: "abcd", password:'test', password_confirmation: 'test')

      expect(@user2.valid?).to eq(true)
    end

    it "verifies that all fields are filled in signup form" do
      @user = User.create(name: '1234', email: "test", password:'test', password_confirmation: 'test')

      expect(@user.valid?).to eq(true)
    end

    it "check empty name field" do
      @user = User.create(name: nil, email: "test", password:'test', password_confirmation: 'test')

      expect(@user.valid?).to eq(false)
    end

    it "check empty email field" do
      @user = User.create(name: '1234', email: nil, password:'test', password_confirmation: 'test')

      expect(@user.valid?).to eq(false)
    end

    it "check password length" do
      @user = User.create(name: 'abcde', email: 'abcde', password:'te', password_confirmation: 'te')

      expect(@user.valid?).to eq(false)
    end
  end

  context '.authenticate_with_credentials' do
    it "should login" do
      @user = User.create(name: 'testt', email: 'testt', password:'testt', password_confirmation: 'testt')

      user = User.authenticate_with_credentials('testt', 'testt')

      expect(user).to eq(@user)
    end

    it "should login with multi-case email" do
      @user = User.create(name: 'testt', email: 'tEStt'.squish.downcase, password:'testt', password_confirmation: 'testt')

      user = User.authenticate_with_credentials('TesTT', 'testt')

      expect(user).to eq(@user)
    end

    it "should login with space-case email" do
      @user = User.create(name: 'testt', email: '  tEStt'.squish.downcase, password:'testt', password_confirmation: 'testt')

      user = User.authenticate_with_credentials('testt', 'testt')

      expect(user).to eq(@user)
    end

  end

  scenario ".authenticate_with_credentials" do
    @user = User.create(name: 'testtt', email: 'testtt'.squish.downcase, password:'testtt', password_confirmation: 'testtt')

    visit "/sessions/new"

    fill_in "sessions[email]", :with => "testtt"
    fill_in "sessions[password]", :with => "testtt"

    click_button "Submit"

    expect(page).to have_text("testtt")
  end

end
