class SafeState
  attr_accessor :display
  attr_accessor :input

  def initialize(display_text="")
    @input = {}
    @input[:pin] = "PIN"

    @display = display_text
  end

  def transition(input)
    SafeState.new
  end
end

class SafeStateError < SafeState
  def initialize(display_text="ERROR")
    super(display_text)
  end
end

class SafeStateReady < SafeState
  def transition(input)
    case input
    when @input[:pin]
      SafeStatePin.new ""
    else
      SafeStateError.new
    end
  end
end

class SafeStatePin < SafeState
  def initialize(display_text="ERROR")
    super(display_text)
    @value = ""
  end

  def transition(input)
    case input
    when @input[:pin]
      if @value.length == 6
        SafeStateReady.new ""
      else
        SafeStateError.new
      end
    when /^[0-9]$/
      @value << input
      @display = input
      self
    else
      SafeStateError.new
    end
  end
end

class Safe
  attr_accessor :pin
  attr_accessor :lock
  attr_accessor :door

  def initialize
    @pin = "123456"
    @lock = :locked
    @door = :closed
    @state = SafeStateReady.new
  end

  def display
    @state.display
  end

  def press(button)
    @state = @state.transition button
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
