### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :email => "example@example.com",
    :password => "please", :password_confirmation => "please", :token => "0b1d42561284289324ae285a1c7defcc" }
end

def find_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  fill_in "Password confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###

Given /^I have not already entered a valid token$/ do
  @visitor = @visitor.merge(:token => nil)
end

Given /^I have already entered a valid token$/ do
end

### WHEN ###

When /^I try to go to the new project page$/ do
  visit '/projects/new'
end

When /^I try to create a project$/ do
  visit '/projects/new'
  fill_in 'Project', :with => "TestProject"
  fill_in 'Name', :with => "Test Project"
  click_button "Create"
end

### THEN ###
Then /^I should be redirected to the \/settings page with a notice to enter a token$/ do
  page.should have_content "Please enter a PivotalTracker API Token"
end

Then /^I should see a successful message$/ do
  page.should have_content "Please enter a PivotalTracker API Token"
end
