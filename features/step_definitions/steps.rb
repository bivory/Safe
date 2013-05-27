class Safe
  attr_accessor :pin
  attr_reader :display
  attr_accessor :lock
  attr_accessor :door

  def initialize
    @pin = "123456"
    @display = "ERROR"
    @lock = :locked
    @door = :closed
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

Then(/^the display shows (\w+)$/) do |message|
  if message == "nothing" then
    message = ""
  end
  @safe.display.should eq(message)
end

Given(/^the safe is locked$/) do
  @safe.lock.should eq(:locked)
end

Given(/^the door is closed$/) do
  @safe.door.should eq(:closed)
end

Then(/^the safe is unlocked$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the door can be opened$/) do
  pending # express the regexp above with the code you wish you had
end
