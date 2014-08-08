require 'capybara/rspec'

RSpec.configure do |config|
end

def sign_up(username)
  visit new_user_url
  fill_in 'username', :with => username
  fill_in 'password', :with => "waffles"
  click_button "Create User"
end

def sign_in(username)
  visit new_session_url
  fill_in 'username', :with => username
  fill_in 'password', :with => "waffles"
  click_button "Sign In"
end


def wipe_users
  User.destroy_all
end

def sign_out
  click_button "Sign Out"
end