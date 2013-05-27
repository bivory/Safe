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

Then(/^the safe is unlocked$/) do
  @safe.lock.should eq(:unlocked)
end

Given(/^the door is closed$/) do
  @safe.door.should eq(:closed)
end

Then(/^the door can be opened$/) do
  @safe.door.should eq(:closed)
  @safe.lock.should eq(:unlocked)
end
