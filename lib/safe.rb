class SafeState
  attr_accessor :display
  attr_accessor :input
  attr_accessor :lock
  attr_accessor :door

  def initialize(display_text: "", lock: :locked, door: :closed)
    @input = {}
    @input[:pin] = "PIN"
    @input[:key] = "KEY"

    @display = display_text
    @lock = lock
    @door = door
  end

  def transition(input)
    SafeState.new
  end
end

class SafeStateError < SafeState
  def initialize(display_text: "ERROR")
    super(display_text: display_text)
  end
end

class SafeStateReady < SafeState
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

class SafeStateNewPin < SafeState
  def initialize()
    super()
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
    when /^[0-9]$/
      @value << input
      @display = input

      if @value.length == 6
        SafeStateReady.new display_text: "OPEN", lock: :unlocked
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

  def initialize
    @pin = "123456"
    @state = SafeStateReady.new
  end

  def lock
    @state.lock
  end

  def door
    @state.door
  end

  def display
    @state.display
  end

  def press(button)
    @state = @state.transition button
  end
end
