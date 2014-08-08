require 'spec_helper'

feature "the home page" do

  before(:each) do
    sign_up("user1")
  end

  it "shows a user's goal list" do
    expect(page).to have_content "Your Goals"
    expect(page).to have_button "Sign Out"
    expect(page).to have_content "user1"
  end

  feature "working with goals" do

    before(:each) do
      add_goal("lose weight")
      click_link 'user1'
      add_goal("eat better", public: false)
      click_link 'user1'
    end

    it "should allow users to create and see goals" do
      expect(page).to have_content "lose weight"
      expect(page).to have_content "eat better"
      expect(page).to_not have_content "lose weight (completed!)"
      expect(page).to_not have_content "eat better (completed!)"
    end

    it "should allow users to delete goals" do
      click_link "eat better"
      click_button "Delete Goal"
      expect(page).to have_content "eat better"
      expect(page).to have_content "lose weight"
      visit current_path
      expect(page).to_not have_content "eat better"
    end

    it "should allow users to modify goals" do
      click_link "lose weight"
      click_button "Edit Goal"
      edit_goal("lose weight by eating better",
                content: "eating more fruits and vegetables has been proven
                          in double blind studies conducted world-wide that fat                           content is burned.")
      expect(page).to have_content "double blind studies"
      click_link "user1"
      expect(page).to have_content "lose weight by eating better"
    end

    it "should allow users to complete goals" do
      click_link "lose weight"
      click_button "Edit Goal"
      edit_goal("lose weight by eating better",
                content: "Lost so much weight.",
                completed: true)
      expect(page).to have_content "Lost so much weight."
      click_link "user1"
      expect(page).to have_content "lose weight by eating better (completed!)"
    end
  end

end