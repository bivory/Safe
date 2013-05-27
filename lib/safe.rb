class SafeState
  attr_accessor :display
  attr_accessor :input
  attr_reader :lock
  attr_reader :door

  def initialize(display_text: "", lock: :locked, door: :closed)
    @input = {}
    @input[:pin] = "PIN"
    @input[:key] = "KEY"

    @pin_length = 6

    @display = display_text
    self.lock = lock
    self.door = door
  end

  def lock=(lock_state)
    @lock = lock_state
    if @lock == :unlocked then
      @display = "OPEN"
    end
  end

  def door=(door_state)
    @door = door_state
  end

  def transition(input)
    case input
    when @input[:pin]
      SafeStateNewPin.new
    when @input[:key]
      SafeStateUnlocking.new
    else
      SafeStateError.new
    end
  end
end

class SafeStateError < SafeState
  def initialize(display_text: "ERROR")
    super(display_text: display_text)
  end
end

class SafeStateNewPin < SafeState
  def initialize()
    super()
    @value = ""
  end

  def transition(input)
    case input
    when @input[:pin]
      if @value.length == @pin_length
        SafeState.new ""
      else
        SafeStateError.new
      end
    when 0..9
      @value << input
      self
    else
      SafeStateError.new
    end
  end
end

class SafeStateUnlocking < SafeState
  def initialize()
    super()
    @value = ""
  end

  def transition(input)
    case input
    when 0..9
      @value << input
      @display = input

      if @value.length == @pin_length
        SafeState.new display_text: "OPEN", lock: :unlocked
      else
        self
      end
    else
      SafeStateError.new
    end
  end
end

class Safe
  attr_accessor :pin

  def initialize(lock: :locked)
    @pin = "123456"
    @state = SafeState.new lock: lock
  end

  def lock
    @state.lock
  end

  def door(door=nil)
    if door.nil? then
      @state.door
    else
      @state.door = door
    end
  end

  def display
    @state.display
  end

  def press(button)
    @state = @state.transition button
  end
end

