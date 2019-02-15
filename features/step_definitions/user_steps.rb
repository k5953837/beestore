# Go to sign up page
Given(/^a user visits sign up page$/) do
  visit new_user_registration_path
end

Given /^the admin user has already signed up$/ do
  @super_admin = FactoryGirl.create(:admin_user)
end

Given /^the normal user has already signed up$/ do
  @normal_user = FactoryGirl.create(:normal_user)
end
