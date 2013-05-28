Given(/^I have a safe$/) do
  @safe = Safe.new
end

Then(/^the PIN should be (#{CAPTURE_NUMBER}) digits$/) do |pin_length|
  @safe.pin_length.should eq(pin_length)
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
  @safe.lock
  @safe.is_locked?.should eq(true)
end

Then(/^the safe is unlocked$/) do
  @safe.unlock
  @safe.is_locked?.should eq(false)
end

Given(/^the door is closed$/) do
  @safe.close_door
  @safe.is_door_open?.should eq(false)
end

Given(/^the door is open$/) do
  @safe.open_door
  @safe.is_door_open?.should eq(true)
end

Then(/^the door can be opened$/) do
  @safe.is_door_open?.should eq(false)
  @safe.is_locked?.should eq(false)
end

Then(/^the safe should be unlocked$/) do
  @safe.is_locked?.should eq(false)
end

Then(/^the safe should be locked$/) do
  @safe.is_locked?.should eq(true)
end

Then(/^the door should be closed$/) do
  @safe.is_door_open?.should eq(false)
end

Then(/^the door should be open$/) do
  @safe.is_door_open?.should eq(true)
end
