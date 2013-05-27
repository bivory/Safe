Given(/^I have a safe$/) do
  @safe = Safe.new
end

Given(/^I have an unlocked safe$/) do
  @safe = Safe.new lock: :unlocked
end

Then(/^the PIN should be (\d+)$/) do |pin|
  @safe.pin.should eq(pin.to_s)
end

Then(/^the PIN should be (#{CAPTURE_NUMBER}) digits$/) do |pin_length|
  @safe.pin.length.should eq(pin_length)
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
