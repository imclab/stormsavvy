Then /^the user should be on his or her dashbaord$/ do
  page.should have_selector("body.dashboard")
  page.should have_selector("body#index")
end

Then /^the user should see "([^"]*)"$/ do |arg1|
  page.should have_selector('h2') do |s|
    s.should have_content(arg1)
  end
end
