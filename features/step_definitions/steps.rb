class Safe
  def initialize
  end
end

Given(/^I have a safe$/) do
  Safe.new
end

Then(/^the PIN should be (\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the PIN should be (\d+) digits$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

