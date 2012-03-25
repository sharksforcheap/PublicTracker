Feature: Create project
  As a user of the website
  I want to be able to create a new project
  so I can have users vote on the stories
  
    Background:
      Given I am logged in

    Scenario: User creates a new project 
      Given I have not already entered a valid token
      When I try to create a project
      Then I should be redirected to the /settings page with a notice to enter a token
      
    Scenario: User creates a new project 
      Given I have already entered a valid token
      When I try to create a project
      Then I should see a successful message