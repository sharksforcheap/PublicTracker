Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my user details

    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see an account edited message
      
    Scenario: I add my Pivotal Token
      Given I am logged in
      When I add my pivotal token
      Then I should see an account edited message
