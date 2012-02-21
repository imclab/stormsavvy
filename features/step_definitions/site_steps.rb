Then /^the user goes to the site index$/ do
  click_link("Sites")
end

Then /^sees "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I debug$/ do
  debugger
end