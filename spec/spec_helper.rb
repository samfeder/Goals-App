require 'capybara/rspec'

RSpec.configure do |config|
end

def sign_up(username)
  visit new_user_url
  fill_in 'Username', :with => username
  fill_in 'Password', :with => "waffles"
  click_button "Sign Up"
end

def sign_in(username)
  visit new_session_url
  fill_in 'Username', :with => username
  fill_in 'Password', :with => "waffles"
  click_button "Sign In"
end

def wipe_users
  User.destroy_all
end

def sign_out
  click_button "Sign Out"
end

def add_goal(goal, content = nil, public = true)
  click_button "Create Goal"
  fill_in 'Title', :with => goal
  fill_in 'Description', :with => content
  choose('private') unless public
  click_button "Create Goal"
end

def edit_goal(options={})
  fill_in 'Title', :with => options[:title]
  fill_in 'Description', :with => options[:content]
  check('completed') if options[:completed]
  choose('Private') unless options[:public]
  click_button "Update Goal"
  save_and_open_page
end