require 'spec_helper'

feature "the goal index page" do

  before(:each) do
    sign_up("user1")
    sign_out
    sign_up("user2")
    click_link "All Users"
    click_link "user1's goals"
  end

  it "allows users to comment on each other's profile" do
    expect(page).to have_content "Comments:"
    expect(page).to have_content "Add Comment"
    expect(page).to have_button "Add Comment"
  end

  feature "adding a comment" do

    before(:each) do
      add_comment("doing good, man...")
    end

    it "should refresh page with new comments" do
      expect(page).to have_content "user2 says:"
      expect(page).to have_content "doing good, man..."
      expect(page).to have_button "Delete Comment"
    end
  end
end

feature "the goal page" do

  before(:each) do
    sign_up("user1")
    add_goal("get comments on this goal")
    sign_out
    sign_up("user2")
    click_link "All Users"
    click_link "user1's goals"
    click_link "get comments on this goal"
  end

  it "allows users to comment on each other's goals" do
    expect(page).to have_content "Comments:"
    expect(page).to have_content "Add Comment"
    expect(page).to have_button "Add Comment"
  end

  feature "adding a comment" do

    before(:each) do
      add_comment("here you go, dude")
    end

    it "should refresh page with new comments" do
      expect(page).to have_content "user2 says:"
      expect(page).to have_content "here you go, dude"
      expect(page).to have_button "Delete Comment"
    end
  end
end