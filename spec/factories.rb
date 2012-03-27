FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    token "0b1d42561284289324ae285a1c7defcc" 
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end