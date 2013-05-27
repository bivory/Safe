class Safe
  attr_accessor :pin

  def initialize
    @pin = "123456"
  end

  def press_pin
  end
end

Given(/^I have a safe$/) do
  @safe = Safe.new
end

Then(/^the PIN should be (\d+)$/) do |arg1|
  @safe.pin.should eq("123456")
end

Then(/^the PIN should be (\d+) digits$/) do |arg1|
  @safe.pin.length.should eq(6)
end

When(/^I hit the PIN button$/) do
  @safe.press_pin
end

When(/^I hit the (\d+) button$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the display shows ERROR$/) do
  pending # express the regexp above with the code you wish you had
end
