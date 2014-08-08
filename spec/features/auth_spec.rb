require 'spec_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
    expect(page).not_to have_content "Sign Out"
  end

  feature "signing up a user" do

    before(:each) do
      wipe_users
      sign_up("testapp")
    end

    it "redirects to goal index page after signup" do
      expect(page).to have_content "Your Goals"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "testapp"
    end
  end
end

feature "signing out" do

  before(:each) do
    wipe_users
    sign_up("testapp")
    click_button "Sign Out"
  end

  it "signs out the current_user" do
    expect(page).to have_content "Sign In"
  end

  it "cannot access user pages" do
    visit goals_url
    expect(page).not_to have_content "Your Goals"
    expect(page).to have_content "Cannot access page"
    expect(page).to have_content "Sign In"
    expect(page).not_to have_content "testapp"
  end
end

feature "signing in" do

  before(:each) do
    wipe_users
    sign_up("testapp")
    click_button "Sign Out"
    sign_in("testapp")
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content "testapp"
  end

  it "redirects to goal index page after sign in" do
    expect(page).to have_content "Your Goals"
  end
end