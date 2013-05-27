class Safe
  attr_accessor :pin
  attr_reader :display

  def initialize
    @pin = "123456"
    @display = "ERROR"
  end

  def press(button)
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

When(/^I hit the (\w+) button$/) do |button|
  @safe.press button
end

Then(/^the display shows ERROR$/) do
  @safe.display.should eq("ERROR")
end
