require 'rails_helper'
require 'spec_helper'

feature "Can move from goal index to new" do
  context "when logged in" do
    before :each do
      login_user
      visit goals_url
    end

    it "goal index has a 'New Goal' link to new goal page" do
      expect(page).to have_link "New Goal"
    end
  end
end

feature "Creating a Goal" do
  context "when logged in" do
    before :each do
      login_user
      visit goals_url
    end

  it "has a New Goal page" do
    expect(page).to have_content "New Goal"
  end

  it "takes a body, sharing sharing" do
    click_link "New Goal"
    expect(page).to have_content "What's your goal?"
    expect(page).to have_content "Sharing"
    expect(page).to have_content "Status"

  end

  it "validates the presence of body and sharing" do
    click_link "New Goal"
    click_button 'Create New Goal'
    expect(page).to have_content 'New Goal'
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Sharing can't be blank"
  end

  it "redirects to the goal show page" do
    click_link "New Goal"
    fill_in "What's your goal?", with: "goal stuff"
    choose('Public')
    choose('not completed')
    click_button "Create New Goal"
    expect(page).to have_content "Back to goals"
  end

end

  context "when logged out" do
    before :each do
      logout_user
    end

    it "redirects to the login page" do
      visit goals_url
      expect(page).to have_content "Sign In"
    end

  end

end

feature "editing goals" do
  context "when logged in" do
    before :each do
      login_user
      visit goals_url
    end

    it "can edit own pages" do
      create_goal
      expect(page).to have_content "Edit Goal"
    end

    it "can go back to Goals from Show page" do
      create_goal
      expect(page).to have_content "Back to goals"
    end

    it "checks goal has a goal" do
      create_goal
      click_link "Edit Goal"
      fill_in "What's your goal?", with: ""
      click_button "Update Goal"
      expect(page).to have_content "Body can't be blank"
    end

  end

  context "when logged out" do
    before :each do
      logout_user
    end

    it "redirects to the login page" do
      visit edit_goal_url(1)
      expect(page).to have_content "Sign In"
    end

  end
end
